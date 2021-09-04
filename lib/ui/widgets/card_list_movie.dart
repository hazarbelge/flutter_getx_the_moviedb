import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/util/index.dart';
import 'package:get/get.dart';

class CardListMovies extends StatelessWidget {
  const CardListMovies({
    Key? key,
    this.onTap,
    required this.image,
    required this.vote,
    required this.title,
    required this.releaseDate,
    required this.genre,
    required this.overview,
  }) : super(key: key);

  final VoidCallback? onTap;
  final String image;
  final String vote;
  final String title;
  final String releaseDate;
  final List<Widget> genre;
  final String overview;

  @override
  Widget build(BuildContext context) {
    final double cardWidth = Get.context?.width ?? Get.width;
    final double cardHeight = cardWidth / (1.75);
    return AspectRatio(
      aspectRatio: 1.75,
      child: Container(
        width: cardWidth,
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 5,
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: onTap,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CardListMovieImageSide(
                  image: image,
                  cardHeight: cardHeight,
                ),
                const SizedBox(width: 25),
                CardListMovieDescSide(
                  cardWidth: cardWidth,
                  cardHeight: cardHeight,
                  vote: vote,
                  title: title,
                  releaseDate: releaseDate,
                  genre: genre,
                  overview: overview,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardListMovieImageSide extends StatelessWidget {
  const CardListMovieImageSide({
    Key? key,
    required this.image,
    required this.cardHeight,
  }) : super(key: key);

  final String image;
  final double cardHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardHeight,
      padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Image.network(
          image,
          fit: BoxFit.fill,
          height: cardHeight - 20,
        ),
      ),
    );
  }
}

class CardListMovieDescSide extends StatelessWidget {
  const CardListMovieDescSide({
    Key? key,
    required this.cardWidth,
    required this.cardHeight,
    required this.vote,
    required this.title,
    required this.releaseDate,
    required this.genre,
    required this.overview,
  }) : super(key: key);

  final double cardWidth;
  final double cardHeight;
  final String vote;
  final String title;
  final String releaseDate;
  final List<Widget> genre;
  final String overview;

  @override
  Widget build(BuildContext context) {
    final bool isTablet = Get.context?.isTablet ?? ((Get.context?.width ?? Get.width) >= 600);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 15, top: 10, bottom: 10),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints boxConstraints) {
            return Container(
              width: boxConstraints.maxWidth,
              height: boxConstraints.maxHeight,
              clipBehavior: Clip.none,
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: boxConstraints.maxHeight / 4.5,
                        height: boxConstraints.maxHeight / 4.5,
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Container(
                                width: cardHeight / 4.5,
                                height: cardHeight / 4.5,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                width: cardHeight / 5,
                                height: cardHeight / 5,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3.0,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    GetRatingColor.getColor(double.parse(vote)),
                                  ),
                                  backgroundColor: Colors.grey,
                                  value: double.parse(vote) / 10.0,
                                ),
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                width: cardHeight / 6,
                                height: cardHeight / 6,
                                child: Center(
                                  child: Text(
                                    '${(double.parse(vote) * 10.0).floor()}%',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: boxConstraints.maxHeight / 4.5,
                        width: boxConstraints.maxWidth - boxConstraints.maxWidth / 4.5 - 10,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: boxConstraints.maxHeight / 8,
                              child: Text(
                                title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: isTablet ? 22 : 14),
                                maxLines: 1,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              releaseDate,
                              style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w300, fontSize: isTablet ? 14 : 11),
                              maxLines: 1,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  if (isTablet) const SizedBox(height: 25) else const SizedBox(height: 10),
                  Expanded(
                    flex: 1,
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.loose,
                      children: <Widget>[
                        Positioned(
                          right: -15,
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            width: boxConstraints.maxWidth + 15,
                            decoration: const BoxDecoration(),
                            child: SingleChildScrollView(
                              clipBehavior: Clip.none,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: <Widget>[
                                  ...genre,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isTablet) const SizedBox(height: 25) else const SizedBox(height: 10),
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        overview,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
