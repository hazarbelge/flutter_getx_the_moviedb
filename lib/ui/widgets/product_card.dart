import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../util/index.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.onTap,
    required this.image,
    required this.vote,
    required this.title,
    required this.releaseDate,
    required this.genre,
    required this.overview,
    required this.aspectRatio,
  }) : super(key: key);

  final VoidCallback? onTap;
  final String image;
  final String vote;
  final String title;
  final String releaseDate;
  final List<Widget> genre;
  final String overview;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    final double cardWidth = Get.context?.width ?? Get.width;
    final double cardHeight = cardWidth / aspectRatio;
    return AspectRatio(
      aspectRatio: aspectRatio,
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
          errorBuilder: (BuildContext context, Object object, StackTrace? stackTrace) {
            return const SizedBox();
          },
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Spacer(),
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
                                  borderRadius: BorderRadius.circular(90),
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
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11.sp,
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
                              height: boxConstraints.maxHeight / 9,
                              child: Text(
                                title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
                                maxLines: 1,
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              height: boxConstraints.maxHeight / 12,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  releaseDate,
                                  style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w300, fontSize: 11.sp),
                                  maxLines: 1,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const Spacer(flex: 2),
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
                  const Spacer(flex: 2),
                  Expanded(
                    flex: 3,
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints boxConstraints) {
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            overview,
                            maxLines: boxConstraints.maxHeight ~/ 14,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 11.sp,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
