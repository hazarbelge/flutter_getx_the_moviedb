import 'package:flutter/material.dart';

class Poster extends StatelessWidget {
  const Poster({
    Key? key,
    required this.posterUrl,
    this.height = 100.0,
  }) : super(key: key);

  static const double POSTER_RATIO = 0.7;

  final String posterUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    final double width = POSTER_RATIO * height;

    return Material(
      borderRadius: BorderRadius.circular(4.0),
      elevation: 2.0,
      child: Image.network(
        posterUrl,
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
    );
  }
}
