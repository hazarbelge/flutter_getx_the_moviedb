import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class BaseDropdownMenu<T> extends StatelessWidget {
  const BaseDropdownMenu({
    Key? key,
    this.suffixIconData = Icons.arrow_forward_ios_outlined,
    this.title,
    this.hintText,
    this.dividerThickness = 1.2,
    this.height = 60,
    required this.value,
    required this.itemList,
    required this.onChanged,
    this.hasError = false,
    this.enableSearch = false,
    this.clearOption = false,
    this.dropDownItemCount = 6,
  }) : super(key: key);

  final IconData suffixIconData;
  final String? title;
  final String? hintText;
  final double dividerThickness;
  final double height;
  final T? value;
  final List<T> itemList;
  final Function(T?)? onChanged;
  final bool hasError;
  final bool enableSearch;
  final bool clearOption;
  final int dropDownItemCount;

  @override
  Widget build(BuildContext context) {
    //final BorderSide borderSide = BorderSide(color: hasError ? ThemeColors.errorColor : ThemeColors.borderColorDisable);

    return SizedBox(
      height: height,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Theme(
              data: ThemeData.dark().copyWith(
                primaryColor: Colors.white,
              ),
              child: DropdownSearch<T>(
                popupProps: PopupProps<T>.menu(
                  showSelectedItems: true,
                  showSearchBox: enableSearch,
                  constraints: BoxConstraints(
                    maxHeight: itemList.length <= 3 ? itemList.length * 60 : 200,
                  ),
                  searchFieldProps: const TextFieldProps(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  menuProps: MenuProps(
                    backgroundColor: Colors.grey.shade800,
                  ),
                  listViewProps: const ListViewProps(
                    physics: ClampingScrollPhysics(),
                  ),
                ),
                items: itemList,
                /*dropdownSearchDecoration: const InputDecoration(
                  labelText: "Menu mode",
                  hintText: "country in menu mode",
                ),*/
                onChanged: onChanged,
                selectedItem: value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
