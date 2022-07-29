import 'package:cached_network_image/cached_network_image.dart';
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
      child: CachedNetworkImage(
        imageUrl: posterUrl,
        filterQuality: FilterQuality.high,
        imageBuilder: (BuildContext context, ImageProvider<Object> imageProvider) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (BuildContext context, String url) => const Center(
          child: SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
        errorWidget: (BuildContext context, String url, dynamic error) => Center(
          heightFactor: 4,
          child: SizedBox(
            height: 40,
            width: 40,
            child: Image.asset("assets/launcher/app_logo.png"),
          ),
        ),
      ),
    );
  }
}
