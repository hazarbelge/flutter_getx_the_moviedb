import 'package:flutter/material.dart';

import '../../models/index.dart';

Widget createGenreContainer(int id) {
  return Container(
    margin: const EdgeInsets.only(right: 10),
    padding: const EdgeInsets.all(8),
    child: Text(
      Genres.genres[id] ?? "",
      style: const TextStyle(fontSize: 12),
    ),
    decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(20)),
  );
}
