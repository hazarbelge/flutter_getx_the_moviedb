import 'package:flutter/material.dart';

class GetRatingColor {
  static Color getColor(double rating) {
    Color color;
    if (rating > 4.5 && rating < 7) {
      color = Colors.yellow;
    } else if (rating >= 7) {
      color = Colors.green;
    } else {
      color = Colors.red;
    }
    return color;
  }
}
