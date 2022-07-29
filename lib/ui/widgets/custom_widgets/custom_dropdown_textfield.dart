import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DropDownTextField extends StatefulWidget {
  const DropDownTextField({
    Key? key,
    this.singleController,
    this.initialValue,
    required this.dropDownList,
    this.padding,
    this.textStyle,
    this.onChanged,
    this.validator,
    this.isEnabled = true,
    this.enableSearch = false,
    this.readOnly = true,
    this.dropdownRadius = 12,
    this.textFieldDecoration,
    this.dropDownItemCount = 6,
    this.searchFocusNode,
    this.textFieldFocusNode,
    this.searchAutofocus = false,
    this.searchShowCursor,
    this.searchKeyboardType,
    this.listSpace = 0,
    this.clearOption = true,
    // this.keyboardHeight = 450,
    this.listPadding,
    this.listTextStyle,
    this.searchText,
  })  : assert(!(initialValue != null && singleController != null),
            "you cannot add both initialValue and singleController,\nset initial value using controller \n\tEg: SingleValueDropDownController(data:initial value) "),
        isMultiSelection = false,
        isForceMultiSelectionClear = false,
        displayCompleteItem = false,
        multiController = null,
        submitButtonColor = null,
        submitButtonText = null,
        submitButtonTextStyle = null,
        super(key: key);

  const DropDownTextField.multiSelection({
    Key? key,
    this.multiController,
    this.displayCompleteItem = false,
    this.initialValue,
    required this.dropDownList,
    this.padding,
    this.textStyle,
    this.isForceMultiSelectionClear = false,
    this.onChanged,
    this.validator,
    this.isEnabled = true,
    this.dropdownRadius = 12,
    this.textFieldDecoration,
    this.dropDownItemCount = 6,
    this.searchFocusNode,
    this.textFieldFocusNode,
    this.listSpace = 0,
    this.clearOption = true,
    this.submitButtonColor,
    this.submitButtonText,
    this.submitButtonTextStyle,
    this.listPadding,
    this.listTextStyle,
    this.searchText,
  })  : assert(initialValue == null || multiController == null,
            "you cannot add both initialValue and multiController\nset initial value using controller\n\tMultiValueDropDownController(data:initial value)"),
        isMultiSelection = true,
        enableSearch = false,
        readOnly = true,
        searchAutofocus = false,
        searchKeyboardType = null,
        searchShowCursor = null,
        singleController = null,
        // keyboardHeight = 0,
        super(key: key);

  ///single dropdown controller,
  final SingleValueDropDownController? singleController;

  ///multi dropdown controller
  final MultiValueDropDownController? multiController;

  ///define the radius of dropdown List ,default value is 12
  final double dropdownRadius;

  ///initial value ,if it is null or not exist in dropDownList then it will not display value.
  final dynamic initialValue;

  ///dropDownList,List of dropdown values
  ///List<DropDownValueModel>
  final List<DropDownValueModel> dropDownList;

  ///function,called when value selected from dropdown.
  ///for single Selection Dropdown it will return single DropDownValueModel object,
  ///and for multi Selection Dropdown ,it will return list of DropDownValueModel object,
  final ValueSetter? onChanged;

  final bool isMultiSelection;

  final TextStyle? textStyle;

  final EdgeInsets? padding;

  ///by setting isForceMultiSelectionClear=true to deselect selected item,only applicable for multi selection dropdown
  final bool isForceMultiSelectionClear;

  ///override default textfield decoration
  final InputDecoration? textFieldDecoration;

  ///by setting isEnabled=false to disable textfield,default value true
  final bool isEnabled;

  final FormFieldValidator<String>? validator;

  ///by setting enableSearch=true enable search option in dropdown,as of now this feature enabled only for single selection dropdown
  final bool enableSearch;

  final bool readOnly;

  ///set displayCompleteItem=true, if you want show complete list of item in textfield else it will display like "number_of_item item selected"
  final bool displayCompleteItem;

  ///Maximum number of dropdown item to display,default value is 6
  final int dropDownItemCount;

  final FocusNode? searchFocusNode;
  final FocusNode? textFieldFocusNode;

  ///override default search keyboard type,only applicable if enableSearch=true,
  final TextInputType? searchKeyboardType;

  ///by setting searchAutofocus=true to autofocus search textfield,only applicable if enableSearch=true,
  ///  ///default value is false
  final bool searchAutofocus;

  ///by setting searchShowCursor=false to hide cursor from search textfield,only applicable if enableSearch=true,
  final bool? searchShowCursor;

  ///by set clearOption=false to hide clear suffix icon button from textfield.
  final bool clearOption;

  ///space between textfield and list ,default value is 0
  final double listSpace;

  ///dropdown List item padding
  final ListPadding? listPadding;

  ///multi dropdown submit button text
  final String? submitButtonText;

  ///multi dropdown submit button color
  final Color? submitButtonColor;

  ///multi dropdown submit button text style
  final TextStyle? submitButtonTextStyle;

  ///dropdown list item text style
  final TextStyle? listTextStyle;

  final String? searchText;

  @override
  _DropDownTextFieldState createState() => _DropDownTextFieldState();
}

class _DropDownTextFieldState extends State<DropDownTextField> with TickerProviderStateMixin {
  static final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);

  late TextEditingController _cnt;
  late String _hintText;

  late bool _isExpanded;
  OverlayEntry? _entry;
  OverlayEntry? _entry2;
  OverlayEntry? _barrierOverlay;
  final LayerLink _layerLink = LayerLink();
  late AnimationController _controller;
  late Animation<double> _heightFactor;
  List<bool> _multiSelectionValue = <bool>[];

  // late String selectedItem;
  late double _height;
  late List<DropDownValueModel> _dropDownList;
  late int _maxListItem;
  late double _searchWidgetHeight;
  late FocusNode _searchFocusNode;
  late FocusNode _textFieldFocusNode;
  late bool _isOutsideClickOverlay;
  late bool _isScrollPadding;
  final int _duration = 150;
  late Offset _offset;
  late bool _searchAutofocus;
  late bool _isPortrait;
  late double _listTileHeight;
  late double _keyboardHeight;
  late TextStyle _listTileTextStyle;
  late ListPadding _listPadding;
  late String? _searchText;

  @override
  void initState() {
    _cnt = TextEditingController();
    _keyboardHeight = 450;
    _searchAutofocus = false;
    _isScrollPadding = false;
    _isOutsideClickOverlay = false;
    _searchFocusNode = widget.searchFocusNode ?? FocusNode();
    _textFieldFocusNode = widget.textFieldFocusNode ?? FocusNode();
    _isExpanded = false;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _duration),
    );
    _heightFactor = _controller.drive(_easeInTween);
    _searchWidgetHeight = 60;
    _hintText = "Select Item";
    _searchText = widget.searchText;
    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus && !_textFieldFocusNode.hasFocus && _isExpanded && !widget.isMultiSelection) {
        _isExpanded = !_isExpanded;
        hideOverlay();
      }
    });
    _textFieldFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus && !_textFieldFocusNode.hasFocus && _isExpanded) {
        _isExpanded = !_isExpanded;
        hideOverlay();
      }
    });

    for (int i = 0; i < widget.dropDownList.length; i++) {
      _multiSelectionValue.add(false);
    }

    ///initial value load
    if (widget.initialValue != null) {
      _dropDownList = List<DropDownValueModel>.from(widget.dropDownList);
      if (widget.isMultiSelection) {
        for (int i = 0; i < widget.initialValue.length; i++) {
          final int index = _dropDownList.indexWhere((DropDownValueModel element) => element.name.trim() == widget.initialValue[i].trim());
          if (index != -1) {
            _multiSelectionValue[i] = true;
          }
        }
        final int count = _multiSelectionValue.where((bool element) => element).toList().length;

        _cnt.text = count == 0
            ? ""
            : widget.displayCompleteItem
                ? widget.initialValue.join(",")
                : "$count item selected";
      } else {
        final int index = _dropDownList.indexWhere((DropDownValueModel element) => element.name.trim() == widget.initialValue.trim());

        if (index != -1) {
          _cnt.text = widget.initialValue;
        }
      }
    }
    updateFunction();
    super.initState();
  }

  Size _textWidgetSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(text: TextSpan(text: text, style: style), maxLines: 1, textDirection: TextDirection.ltr)..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  void updateFunction({DropDownTextField? oldWidget}) {
    final Function eq = const DeepCollectionEquality().equals;
    _dropDownList = List<DropDownValueModel>.from(widget.dropDownList);
    _listPadding = widget.listPadding ?? ListPadding();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isMultiSelection) {
        if (oldWidget != null && !eq(oldWidget.dropDownList, _dropDownList)) {
          _multiSelectionValue = <bool>[];
          _cnt.text = "";
          for (int i = 0; i < _dropDownList.length; i++) {
            _multiSelectionValue.add(false);
          }
        }
        if (widget.isForceMultiSelectionClear && _multiSelectionValue.isNotEmpty) {
          _multiSelectionValue = <bool>[];
          _cnt.text = "";
          for (int i = 0; i < _dropDownList.length; i++) {
            _multiSelectionValue.add(false);
          }
        }

        // if (widget.multiController != null) {
        //   List<DropDownValueModel> multiCnt = [];
        //   for (int i = 0; i < dropDownList.length; i++) {
        //     if (multiSelectionValue[i]) {
        //       multiCnt.add(dropDownList[i]);
        //     }
        //   }
        //   widget.multiController!
        //       .setDropDown(multiCnt.isNotEmpty ? multiCnt : null);
        // }

        if (widget.multiController != null) {
          if (oldWidget != null && oldWidget.multiController!.dropDownValueList != null) {}
          if (widget.multiController!.dropDownValueList != null) {
            _multiSelectionValue = <bool>[];
            for (int i = 0; i < _dropDownList.length; i++) {
              _multiSelectionValue.add(false);
            }
            for (int i = 0; i < widget.multiController!.dropDownValueList!.length; i++) {
              final int index = _dropDownList.indexWhere((DropDownValueModel element) => element == widget.multiController!.dropDownValueList![i]);
              if (index != -1) {
                _multiSelectionValue[index] = true;
              }
            }
            final int count = _multiSelectionValue.where((bool element) => element).toList().length;
            _cnt.text = count == 0
                ? ""
                : widget.displayCompleteItem
                    ? widget.initialValue.join(",")
                    : "$count item selected";
          } else {
            _multiSelectionValue = <bool>[];
            _cnt.text = "";
            for (int i = 0; i < _dropDownList.length; i++) {
              _multiSelectionValue.add(false);
            }
          }
        }
      } else {
        if (widget.singleController != null) {
          if (widget.singleController!.dropDownValue != null) {
            _cnt.text = widget.singleController!.dropDownValue!.name;
          } else {
            _cnt.clear();
          }
        }
      }

      _listTileTextStyle = (widget.listTextStyle ?? Theme.of(context).textTheme.subtitle1)!;
      _listTileHeight = _textWidgetSize("dummy Text", _listTileTextStyle).height + _listPadding.top + _listPadding.bottom;
      _maxListItem = widget.dropDownItemCount;

      _height = (!widget.isMultiSelection
              ? (_dropDownList.length < _maxListItem ? _dropDownList.length * _listTileHeight : _listTileHeight * _maxListItem.toDouble())
              : _dropDownList.length < _maxListItem
                  ? _dropDownList.length * _listTileHeight
                  : _listTileHeight * _maxListItem.toDouble()) +
          10;
    });
  }

  @override
  void didUpdateWidget(covariant DropDownTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateFunction(oldWidget: oldWidget);
  }

  @override
  void dispose() {
    if (widget.searchFocusNode == null) {
      _searchFocusNode.dispose();
    }
    if (widget.textFieldFocusNode == null) {
      _textFieldFocusNode.dispose();
    }
    _cnt.dispose();
    super.dispose();
  }

  void clearFun() {
    if (_isExpanded) {
      _isExpanded = !_isExpanded;
      hideOverlay();
    }
    _cnt.clear();
    if (widget.isMultiSelection) {
      if (widget.multiController != null) {
        widget.multiController!.setDropDown(null);
      }
      if (widget.onChanged != null) {
        widget.onChanged!(<bool>[]);
      }

      _multiSelectionValue = <bool>[];
      for (int i = 0; i < _dropDownList.length; i++) {
        _multiSelectionValue.add(false);
      }
    } else {
      if (widget.singleController != null) {
        widget.singleController!.setDropDown(null);
      }
      if (widget.onChanged != null) {
        widget.onChanged!("");
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return KeyboardVisibilityBuilder(
      builder: (BuildContext context, bool isKeyboardVisible) {
        if (!isKeyboardVisible && _isExpanded && _isScrollPadding) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            shiftOverlayEntry2to1();
          });
        }
        return CompositedTransformTarget(
          link: _layerLink,
          child: TextFormField(
            focusNode: _textFieldFocusNode,
            style: widget.textStyle,
            enabled: widget.isEnabled,
            readOnly: widget.readOnly,
            controller: _cnt,
            onTap: () {
              _searchAutofocus = widget.searchAutofocus;
              if (!_isExpanded) {
                if (_dropDownList.isNotEmpty) {
                  _showOverlay();
                }
              } else {
                hideOverlay();
              }
            },
            validator: (String? value) => widget.validator != null ? widget.validator!(value) : null,
            decoration: widget.textFieldDecoration != null
                ? widget.textFieldDecoration!.copyWith(
                    suffixIcon: (_cnt.text.isEmpty || !widget.clearOption)
                        ? const Icon(
                            Icons.arrow_drop_down_outlined,
                          )
                        : widget.clearOption
                            ? InkWell(
                                onTap: clearFun,
                                child: const Icon(
                                  Icons.clear,
                                ),
                              )
                            : null,
                  )
                : InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: _hintText,
                    hintStyle: const TextStyle(fontWeight: FontWeight.normal),
                    suffixIcon: (_cnt.text.isEmpty || !widget.clearOption)
                        ? const Icon(
                            Icons.arrow_drop_down_outlined,
                          )
                        : widget.clearOption
                            ? InkWell(
                                onTap: clearFun,
                                child: const Icon(
                                  Icons.clear,
                                ),
                              )
                            : null,
                  ),
          ),
        );
      },
    );
  }

  Future<void> _showOverlay() async {
    _controller.forward();
    _isExpanded = true;
    final OverlayState? overlay = Overlay.of(context);
    final RenderBox renderBox = context.findRenderObject()! as RenderBox;
    final Size size = renderBox.size;
    _offset = renderBox.localToGlobal(Offset.zero);
    final double posFromTop = _offset.dy;
    final double posFromBot = MediaQuery.of(context).size.height - posFromTop;

    final double dropdownListHeight = _height + (widget.enableSearch ? _searchWidgetHeight : 0) + widget.listSpace;
    final double ht = dropdownListHeight + 120;
    if (_searchAutofocus && !(posFromBot < ht) && posFromBot < _keyboardHeight && !_isScrollPadding && _isPortrait) {
      _isScrollPadding = true;
    }
    _isOutsideClickOverlay = _isScrollPadding || (widget.readOnly && dropdownListHeight > (posFromTop - MediaQuery.of(context).padding.top - 15) && posFromBot < ht);
    final double topPaddingHeight = _isOutsideClickOverlay ? (dropdownListHeight - (posFromTop - MediaQuery.of(context).padding.top - 15)) : 0;

    final double htPos = posFromBot < ht
        ? size.height - 100 + topPaddingHeight
        : _isScrollPadding
            ? size.height - (_keyboardHeight - posFromBot)
            : size.height;
    if (_isOutsideClickOverlay) {
      _openOutSideClickOverlay(context);
    }
    _entry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
          width: size.width,
          child: CompositedTransformFollower(
              targetAnchor: posFromBot < ht ? Alignment.bottomCenter : Alignment.topCenter,
              followerAnchor: posFromBot < ht ? Alignment.bottomCenter : Alignment.topCenter,
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(
                0,
                posFromBot < ht ? htPos - widget.listSpace : htPos + widget.listSpace,
              ),
              child: AnimatedBuilder(
                animation: _controller.view,
                builder: buildOverlay,
              ))),
    );
    _entry2 = OverlayEntry(
      builder: (BuildContext context) => Positioned(
          width: size.width,
          child: CompositedTransformFollower(
              targetAnchor: Alignment.bottomCenter,
              followerAnchor: Alignment.bottomCenter,
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(
                0,
                htPos,
              ),
              child: AnimatedBuilder(
                animation: _controller.view,
                builder: buildOverlay,
              ))),
    );
    overlay?.insert(_isScrollPadding ? _entry2! : _entry!);
  }

  void _openOutSideClickOverlay(BuildContext context) {
    final OverlayState? overlay2 = Overlay.of(context);
    _barrierOverlay = OverlayEntry(builder: (BuildContext context) {
      final Size size = MediaQuery.of(context).size;
      return GestureDetector(
        onTap: () {
          hideOverlay();
        },
        child: Container(
          width: size.width,
          height: size.height,
          color: Colors.transparent,
        ),
      );
    });
    overlay2?.insert(_barrierOverlay!);
  }

  void hideOverlay() {
    if (!_isScrollPadding) {}
    _controller.reverse().then<void>((void value) {
      if (_entry != null && _entry!.mounted) {
        _entry?.remove();
        _entry = null;
      }
      if (_entry2 != null && _entry2!.mounted) {
        _entry2?.remove();
        _entry2 = null;
      }

      if (_barrierOverlay != null && _barrierOverlay!.mounted) {
        _barrierOverlay?.remove();
        _barrierOverlay = null;
        _isOutsideClickOverlay = false;
      }
      _isScrollPadding = false;
      _isExpanded = false;
    });
  }

  void shiftOverlayEntry1to2() {
    _entry?.remove();
    _entry = null;
    if (_barrierOverlay != null && _barrierOverlay!.mounted) {
      _barrierOverlay?.remove();
      _barrierOverlay = null;
      _isOutsideClickOverlay = false;
    }
    _isScrollPadding = true;
    _showOverlay();
    _textFieldFocusNode.requestFocus();

    Future<dynamic>.delayed(Duration(milliseconds: _duration), () {
      _searchFocusNode.requestFocus();
    });
  }

  void shiftOverlayEntry2to1() {
    _searchAutofocus = false;
    _entry2?.remove();
    _entry2 = null;
    if (_barrierOverlay != null && _barrierOverlay!.mounted) {
      _barrierOverlay?.remove();
      _barrierOverlay = null;
      _isOutsideClickOverlay = false;
    }
    _controller.reset();
    _isScrollPadding = false;
    _showOverlay();
    _textFieldFocusNode.requestFocus();
  }

  Widget buildOverlay(BuildContext context, Widget? child) {
    return ClipRect(
      child: Align(
        heightFactor: _heightFactor.value,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(widget.dropdownRadius)),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: !widget.isMultiSelection
                  ? SingleSelection(
                      mainController: _cnt,
                      autoSort: !widget.readOnly,
                      mainFocusNode: _textFieldFocusNode,
                      searchFocusNode: _searchFocusNode,
                      enableSearch: widget.enableSearch,
                      height: _height,
                      listTileHeight: _listTileHeight,
                      dropDownList: _dropDownList,
                      listTextStyle: _listTileTextStyle,
                      searchText: _searchText,
                      onChanged: (dynamic item) {
                        setState(() {
                          _cnt.text = item.name;
                          _isExpanded = !_isExpanded;
                        });
                        if (widget.singleController != null) {
                          widget.singleController!.setDropDown(item);
                        }
                        if (widget.onChanged != null) {
                          widget.onChanged!(item);
                        }
                        // Navigator.pop(context, null);

                        hideOverlay();
                      },
                      searchHeight: _searchWidgetHeight,
                      searchKeyboardType: widget.searchKeyboardType,
                      searchAutofocus: _searchAutofocus,
                      searchShowCursor: widget.searchShowCursor,
                      listPadding: _listPadding,
                      onSearchTap: () {
                        final double posFromBot = MediaQuery.of(context).size.height - _offset.dy;
                        if (posFromBot < _keyboardHeight && !_isScrollPadding && _isPortrait) {
                          shiftOverlayEntry1to2();
                        }
                      },
                      onSearchSubmit: () {
                        if (_isScrollPadding) {
                          shiftOverlayEntry2to1();
                        }
                      })
                  : MultiSelection(
                      buttonTextStyle: widget.submitButtonTextStyle,
                      buttonText: widget.submitButtonText,
                      buttonColor: widget.submitButtonColor,
                      height: _height,
                      listTileHeight: _listTileHeight,
                      list: _multiSelectionValue,
                      dropDownList: _dropDownList,
                      listTextStyle: _listTileTextStyle,
                      listPadding: _listPadding,
                      onChanged: (List<bool> val) {
                        _isExpanded = !_isExpanded;
                        _multiSelectionValue = val;
                        final List<DropDownValueModel> result = <DropDownValueModel>[];
                        final List<dynamic> completeList = <dynamic>[];
                        for (int i = 0; i < _multiSelectionValue.length; i++) {
                          if (_multiSelectionValue[i]) {
                            result.add(_dropDownList[i]);
                            completeList.add(_dropDownList[i].name);
                          }
                        }
                        final int count = _multiSelectionValue.where((bool element) => element).toList().length;

                        _cnt.text = count == 0
                            ? ""
                            : widget.displayCompleteItem
                                ? completeList.join(",")
                                : "$count item selected";
                        if (widget.multiController != null) {
                          widget.multiController!.setDropDown(result.isNotEmpty ? result : null);
                        }
                        if (widget.onChanged != null) {
                          widget.onChanged!(result);
                        }

                        hideOverlay();

                        setState(() {});
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class SingleSelection extends StatefulWidget {
  const SingleSelection({
    Key? key,
    required this.dropDownList,
    required this.onChanged,
    required this.height,
    required this.enableSearch,
    required this.searchHeight,
    required this.searchFocusNode,
    required this.mainFocusNode,
    this.searchKeyboardType,
    required this.searchAutofocus,
    this.searchShowCursor,
    required this.mainController,
    required this.autoSort,
    required this.listTileHeight,
    this.onSearchTap,
    this.onSearchSubmit,
    this.listTextStyle,
    required this.listPadding,
    this.searchText,
  }) : super(key: key);
  final List<DropDownValueModel> dropDownList;
  final ValueSetter onChanged;
  final double height;
  final double listTileHeight;
  final bool enableSearch;
  final double searchHeight;
  final FocusNode searchFocusNode;
  final FocusNode mainFocusNode;
  final TextInputType? searchKeyboardType;
  final bool searchAutofocus;
  final bool? searchShowCursor;
  final TextEditingController mainController;
  final bool autoSort;
  final Function? onSearchTap;
  final Function? onSearchSubmit;
  final TextStyle? listTextStyle;
  final ListPadding listPadding;
  final String? searchText;

  @override
  State<SingleSelection> createState() => _SingleSelectionState();
}

class _SingleSelectionState extends State<SingleSelection> {
  late List<DropDownValueModel> newDropDownList;
  late TextEditingController _searchCnt;
  late FocusScopeNode _focusScopeNode;

  void onItemChanged(String value) {
    setState(() {
      if (value.isEmpty) {
        newDropDownList = List<DropDownValueModel>.from(widget.dropDownList);
      } else {
        newDropDownList = widget.dropDownList.where((DropDownValueModel item) => item.name.toLowerCase().contains(value.toLowerCase())).toList();
      }
    });
  }

  @override
  void initState() {
    _focusScopeNode = FocusScopeNode();
    if (widget.searchAutofocus) {
      widget.searchFocusNode.requestFocus();
    }
    _focusScopeNode.requestFocus();
    newDropDownList = List<DropDownValueModel>.from(widget.dropDownList);
    _searchCnt = TextEditingController();
    if (widget.autoSort) {
      onItemChanged(widget.mainController.text);
      widget.mainController.addListener(() {
        if (mounted) {
          onItemChanged(widget.mainController.text);
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _searchCnt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (widget.enableSearch)
          SizedBox(
            height: widget.searchHeight,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                focusNode: widget.searchFocusNode,
                showCursor: widget.searchShowCursor,
                keyboardType: widget.searchKeyboardType,
                controller: _searchCnt,
                onTap: () {
                  if (widget.onSearchTap != null) {
                    widget.onSearchTap!();
                  }
                },
                decoration: InputDecoration(
                  hintText: widget.searchText ?? 'Search Here...',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      widget.mainFocusNode.requestFocus();
                      _searchCnt.clear();
                      onItemChanged("");
                    },
                    child: widget.searchFocusNode.hasFocus
                        ? const InkWell(
                            child: Icon(Icons.close),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
                onChanged: onItemChanged,
                onSubmitted: (String val) {
                  widget.mainFocusNode.requestFocus();
                  if (widget.onSearchSubmit != null) {
                    widget.onSearchSubmit!();
                  }
                },
              ),
            ),
          ),
        SizedBox(
          height: widget.height,
          child: Scrollbar(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: newDropDownList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    widget.onChanged(newDropDownList[index]);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: widget.listPadding.bottom, top: widget.listPadding.top),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(newDropDownList[index].name, style: widget.listTextStyle),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class MultiSelection extends StatefulWidget {
  const MultiSelection(
      {Key? key,
      required this.onChanged,
      required this.dropDownList,
      required this.list,
      required this.height,
      this.buttonColor,
      this.buttonText,
      this.buttonTextStyle,
      required this.listTileHeight,
      required this.listPadding,
      this.listTextStyle})
      : super(key: key);
  final List<DropDownValueModel> dropDownList;
  final ValueSetter<List<bool>> onChanged;
  final List<bool> list;
  final double height;
  final Color? buttonColor;
  final String? buttonText;
  final TextStyle? buttonTextStyle;
  final double listTileHeight;
  final TextStyle? listTextStyle;
  final ListPadding listPadding;

  @override
  _MultiSelectionState createState() => _MultiSelectionState();
}

class _MultiSelectionState extends State<MultiSelection> {
  List<bool> multiSelectionValue = <bool>[];

  @override
  void initState() {
    multiSelectionValue = List<bool>.from(widget.list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: widget.height,
          child: Scrollbar(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: widget.dropDownList.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: widget.listTileHeight,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: widget.listPadding.bottom, top: widget.listPadding.top),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(widget.dropDownList[index].name, style: widget.listTextStyle),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Checkbox(
                            value: multiSelectionValue[index],
                            onChanged: (bool? value) {
                              if (value != null) {
                                setState(() {
                                  multiSelectionValue[index] = value;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
        Row(
          children: <Widget>[
            const Expanded(
              child: SizedBox.shrink(),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 15, bottom: 10),
              child: InkWell(
                onTap: () => widget.onChanged(multiSelectionValue),
                child: Container(
                  height: widget.listTileHeight * 0.9,
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12),
                  decoration: BoxDecoration(color: widget.buttonColor ?? Colors.green, borderRadius: const BorderRadius.all(Radius.circular(12))),
                  child: Align(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        widget.buttonText ?? "OK",
                        style: widget.buttonTextStyle ?? const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DropDownValueModel extends Equatable {
  const DropDownValueModel({
    required this.name,
    required this.value,
  });

  factory DropDownValueModel.fromJson(Map<String, dynamic> json) => DropDownValueModel(
        name: json["name"],
        value: json["value"],
      );
  final String name;
  final dynamic value;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "name": name,
        "value": value,
      };

  @override
  List<Object> get props => <Object>[name, value];
}

class SingleValueDropDownController extends ChangeNotifier {
  SingleValueDropDownController({DropDownValueModel? data}) {
    setDropDown(data);
  }

  DropDownValueModel? dropDownValue;

  void setDropDown(DropDownValueModel? model) {
    dropDownValue = model;
    notifyListeners();
  }

  void clearDropDown() {
    dropDownValue = null;
    notifyListeners();
  }
}

class MultiValueDropDownController extends ChangeNotifier {
  MultiValueDropDownController({List<DropDownValueModel>? data}) {
    setDropDown(data);
  }

  List<DropDownValueModel>? dropDownValueList;

  void setDropDown(List<DropDownValueModel>? modelList) {
    if (modelList != null && modelList.isNotEmpty) {
      final List<DropDownValueModel> list = <DropDownValueModel>[];
      for (final DropDownValueModel item in modelList) {
        if (!list.contains(item)) {
          list.add(item);
        }
      }
      dropDownValueList = list;
    } else {
      dropDownValueList = null;
    }
    notifyListeners();
  }

  void clearDropDown() {
    dropDownValueList = null;
    notifyListeners();
  }
}

class ListPadding {
  ListPadding({this.top = 15, this.bottom = 15});

  double top;
  double bottom;
}

class KeyboardVisibilityBuilder extends StatefulWidget {
  const KeyboardVisibilityBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);
  final Widget Function(
    BuildContext context,
    bool isKeyboardVisible,
  ) builder;

  @override
  _KeyboardVisibilityBuilderState createState() => _KeyboardVisibilityBuilderState();
}

class _KeyboardVisibilityBuilderState extends State<KeyboardVisibilityBuilder> with WidgetsBindingObserver {
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final double bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    final bool newValue = bottomInset > 0.0;
    if (newValue != _isKeyboardVisible) {
      setState(() {
        _isKeyboardVisible = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(
        context,
        _isKeyboardVisible,
      );
}
