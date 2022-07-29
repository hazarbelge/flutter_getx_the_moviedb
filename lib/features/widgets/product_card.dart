import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/core/utils/index.dart';

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
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Container(
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
                Expanded(
                  flex: 3,
                  child: CardListMovieImageSide(
                    image: image,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  flex: 6,
                  child: CardListMovieDescSide(
                    vote: vote,
                    title: title,
                    releaseDate: releaseDate,
                    genre: genre,
                    overview: overview,
                  ),
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
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: CachedNetworkImage(
          imageUrl: image,
          filterQuality: FilterQuality.high,
          imageBuilder: (BuildContext context, ImageProvider<Object> imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (BuildContext context, String url) => const SizedBox(
            child: Center(
              child: SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          ),
          errorWidget: (BuildContext context, String url, dynamic error) => SizedBox(
            child: Center(
              child: SizedBox(
                height: 40,
                width: 40,
                child: Image.asset("assets/launcher/app_logo.png"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardListMovieDescSide extends StatelessWidget {
  const CardListMovieDescSide({
    Key? key,
    required this.vote,
    required this.title,
    required this.releaseDate,
    required this.genre,
    required this.overview,
  }) : super(key: key);

  final String vote;
  final String title;
  final String releaseDate;
  final List<Widget> genre;
  final String overview;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, top: 10, bottom: 10),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints boxConstraints) {
          return Container(
            width: boxConstraints.maxWidth,
            height: boxConstraints.maxHeight,
            clipBehavior: Clip.none,
            decoration: const BoxDecoration(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Spacer(),
                Expanded(
                  flex: 4,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Transform.scale(
                                scale: 1.2,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
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
                            ),
                            Center(
                              child: Text(
                                '${(double.parse(vote) * 10.0).floor()}%',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        flex: 6,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                title,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
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
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 11,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 8,
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints boxConstraints) {
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          overview,
                          maxLines: boxConstraints.maxHeight ~/ 14,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
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
    );
  }
}
