import "package:flutter/material.dart";

class BaseButton extends StatelessWidget {
  const BaseButton({
    Key? key,
    required this.backgroundColor,
    this.foregroundColor = Colors.transparent,
    this.textColor = Colors.white,
    this.text,
    this.fontSize,
    this.fontWeight = FontWeight.w600,
    this.borderRadius = 12,
    required this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.borderColor = Colors.transparent,
    this.borderWidth = 1,
    this.elevation = 2,
    this.shape,
    this.paddings = const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
  }) : super(key: key);

  final Color backgroundColor;
  final Color foregroundColor;
  final Color textColor;
  final String? text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double borderRadius;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final FocusNode? focusNode;
  final Color borderColor;
  final double borderWidth;
  final double elevation;
  final MaterialStateProperty<OutlinedBorder?>? shape;
  final EdgeInsets paddings;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        try {
          onPressed();
        } catch (e) {
          debugPrint("ButtonPressedError: $e");
        }
      },
      onLongPress: onLongPress,
      focusNode: focusNode,
      clipBehavior: Clip.antiAlias,
      style: ButtonStyle(
        elevation: MaterialStateProperty.resolveWith((Set<MaterialState> states) => elevation),
        backgroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) => backgroundColor),
        foregroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) => foregroundColor),
        shape: shape ??
            MaterialStateProperty.resolveWith(
              (Set<MaterialState> states) => RoundedRectangleBorder(
                side: BorderSide(
                  color: borderColor,
                  width: borderWidth,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
        padding: MaterialStateProperty.resolveWith((Set<MaterialState> states) => paddings),
      ),
      child: Text(
        text ?? "",
        style: TextStyle(
          color: textColor,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
