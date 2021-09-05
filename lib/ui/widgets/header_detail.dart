import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black38,
          child: BannerImage(imageUrl: imageBanner),
        ),
        Positioned(
          bottom: 10.0,
          left: 16.0,
          right: 16.0,
          child: SizedBox(
            width: Get.context?.width ?? Get.width - 16,
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Poster(
                  posterUrl: imagePoster,
                  height: 200,
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      RatingRow(
                        rating: rating,
                        id: movieId,
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
        ),
      ],
    );
  }
}
