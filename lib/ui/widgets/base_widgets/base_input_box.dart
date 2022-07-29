import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'package:flutter_getx_the_moviedb/core/theme/index.dart';

class BaseInputBox extends StatelessWidget {
  const BaseInputBox({
    Key? key,
    this.hintText,
    this.labelText,
    this.textEditingController,
    this.focusNode,
    this.nextFocusNode,
    this.obscureText = false,
    this.textInputAction,
    this.keyboardType,
    this.autofillHints,
    this.decoration,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.style,
    this.enabled = true,
    this.inputFormatters,
    this.maxLines = 1,
    this.maxLength,
    this.maxLengthEnforcement,
    this.cursorColor,
  }) : super(key: key);

  final String? hintText;
  final String? labelText;
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final List<String>? autofillHints;
  final InputDecoration? decoration;
  final Function(String?)? onChanged;
  final VoidCallback? onEditingComplete;
  final Function(String?)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final TextStyle? style;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final Color? cursorColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: textEditingController,
      focusNode: focusNode,
      obscureText: obscureText,
      textInputAction: textInputAction,
      keyboardType: keyboardType ?? TextInputType.visiblePassword,
      autofillHints: autofillHints ?? <String>[],
      autocorrect: false,
      enableSuggestions: false,
      maxLength: maxLength,
      maxLengthEnforcement: maxLengthEnforcement,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: (String? value) {
        if (focusNode != null) {
          focusNode!.unfocus();
        }
        if (onFieldSubmitted != null) {
          onFieldSubmitted!(value);
        }
        if (nextFocusNode != null) {
          nextFocusNode!.requestFocus();
        }
      },
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      readOnly: readOnly,
      style: style ??
          const TextStyle(
            color: ThemeColors.primaryTextColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
      cursorColor: cursorColor ?? ThemeColors.primaryColor,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      decoration: decoration ??
          InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ThemeColors.borderColorEnable),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ThemeColors.borderColorDisable),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: ThemeColors.borderColorDisable),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ThemeColors.errorColor),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ThemeColors.errorColor),
            ),
            labelText: labelText,
            hintText: hintText,
            alignLabelWithHint: true,
            disabledBorder: null,
            hintStyle: const TextStyle(
              color: ThemeColors.secondaryTextColor,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            labelStyle: const TextStyle(
              color: ThemeColors.secondaryTextColor,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
    );
  }
}
