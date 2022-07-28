import "package:flutter/material.dart";
import 'package:flutter_getx_the_moviedb/core/theme/index.dart';

class CustomRefreshIndicator extends StatelessWidget {
  const CustomRefreshIndicator({
    Key? key,
    required this.onRefresh,
    required this.child,
    this.displacement = 40.0,
    this.edgeOffset = 0.0,
  }) : super(key: key);

  final Future<void> Function() onRefresh;
  final Widget child;
  final double displacement;
  final double edgeOffset;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: ThemeColors.secondaryColor,
      backgroundColor: ThemeColors.primaryColor,
      child: child,
      displacement: displacement,
      edgeOffset: edgeOffset,
    );
  }
}
