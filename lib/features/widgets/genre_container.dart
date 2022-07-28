import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/models/index.dart';

Widget createGenreContainer(Genre genre) {
  return Container(
    margin: const EdgeInsets.only(right: 10),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.black,
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      genre.name ?? "",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
    ),
  );
}
