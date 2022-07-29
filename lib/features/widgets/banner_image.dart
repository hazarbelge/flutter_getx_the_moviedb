import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BannerImage extends StatelessWidget {
  const BannerImage({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return CachedNetworkImage(
      imageUrl: imageUrl,
      filterQuality: FilterQuality.high,
      imageBuilder: (BuildContext context, ImageProvider<Object> imageProvider) => Container(
        width: double.infinity,
        height: height / 1.6,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (BuildContext context, String url) => SizedBox(
        width: double.infinity,
        height: height / 1.6,
        child: const Center(
          child: SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      ),
      errorWidget: (BuildContext context, String url, dynamic error) => const SizedBox(),
    );
  }
}
