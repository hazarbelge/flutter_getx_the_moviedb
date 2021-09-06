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
    required this.id,
    required this.rating,
    required this.isMovie,
  }) : super(key: key);

  final List<Widget> genre;
  final String title;
  final String imageBanner;
  final String imagePoster;
  final double rating;
  final int id;
  final bool isMovie;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          color: Colors.black38,
          child: BannerImage(imageUrl: imageBanner),
        ),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints boxConstraints) {
            if (boxConstraints.maxWidth >= 390) {
              return Container(
                width: boxConstraints.maxWidth,
                height: (height / 1.6) - 10,
                padding: const EdgeInsets.only(left: 16.0, bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Poster(
                      posterUrl: imagePoster,
                      height: 190,
                    ),
                    const SizedBox(width: 16.0),
                    SizedBox(
                      height: 190,
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
                              maxLines: 1,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          RatingRow(
                            rating: rating,
                            id: id,
                            isMovie: isMovie,
                          ),
                          const SizedBox(height: 12.0),
                          SizedBox(
                            width: boxConstraints.maxWidth - (190 * 0.7) - 32,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: genre,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                width: boxConstraints.maxWidth,
                height: (height / 1.6) - 10,
                padding: const EdgeInsets.only(left: 16.0, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Poster(
                      posterUrl: imagePoster,
                      height: height / 4,
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Text(
                        title,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    RatingRow(
                      rating: rating,
                      id: id,
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
              );
            }
          },
        ),
        Positioned(
          top: 20,
          left: 5,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, size: 36),
            onPressed: () => Get.back(),
          ),
        ),
      ],
    );
  }
}
