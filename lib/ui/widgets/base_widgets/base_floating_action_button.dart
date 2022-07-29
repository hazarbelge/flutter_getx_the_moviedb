import "package:flutter/material.dart";
import 'package:flutter_getx_the_moviedb/core/theme/index.dart';

class BaseFloatingActionButton extends StatelessWidget {
  const BaseFloatingActionButton({
    Key? key,
    this.onPressed,
    this.elevation,
    this.backgroundColor,
    this.foregroundColor,
    required this.iconData,
    this.iconSize,
    this.iconColor,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final double? elevation;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconData iconData;
  final double? iconSize;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      elevation: elevation ?? 5,
      backgroundColor: backgroundColor ?? ThemeColors.primaryColor,
      foregroundColor: foregroundColor,
      child: Icon(
        iconData,
        size: iconSize,
        color: iconColor ?? Colors.black,
      ),
    );
  }
}
