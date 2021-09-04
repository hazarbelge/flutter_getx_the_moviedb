import 'package:flutter/material.dart';

import 'index.dart';

class HeaderDetail extends StatelessWidget {
  const HeaderDetail({
    Key? key,
    required this.genre,
    required this.title,
    required this.imageBanner,
    required this.imagePoster,
    required this.movieId,
    required this.rating,
    required this.isMovie,
  }) : super(key: key);

  final List<Widget> genre;
  final String title;
  final String imageBanner;
  final String imagePoster;
  final double rating;
  final int movieId;
  final bool isMovie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 140.0),
          child: BannerImage(imageUrl: imageBanner),
        ),
        Positioned(
          bottom: 0.0,
          left: 16.0,
          right: 16.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Poster(
                posterUrl: imagePoster,
                height: 180.0,
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color.fromRGBO(58, 66, 86, 1.0),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    RatingRow(
                      rating: rating,
                      movieId: movieId,
                      isMovie: isMovie,
                    ),
                    const SizedBox(height: 12.0),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: genre,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
