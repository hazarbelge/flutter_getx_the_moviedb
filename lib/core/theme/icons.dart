import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ThemeIcons {
  const ThemeIcons({
    this.color,
    this.height = 24.0,
    this.width = 24.0,
    this.name = 'assets/icons/app_icon.svg',
  });

  final Color? color;
  final double height;
  final double width;
  final String name;

  SvgPicture get theMovieDBLogo {
    return SvgPicture.asset(
      'assets/icons/app_icon.svg',
      height: height,
      width: width,
      color: color,
      colorBlendMode: BlendMode.srcATop,
      semanticsLabel: '',
    );
  }
}
