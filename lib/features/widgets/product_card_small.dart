import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCardSmall extends StatelessWidget {
  const ProductCardSmall({
    Key? key,
    this.onTap,
    required this.image,
    required this.title,
    required this.aspectRatio,
    required this.maxWidth,
  }) : super(key: key);

  final VoidCallback? onTap;
  final String image;
  final String title;
  final double aspectRatio;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        child: Row(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: image,
              filterQuality: FilterQuality.high,
              imageBuilder: (BuildContext context, ImageProvider<Object> imageProvider) => Container(
                height: ((Get.context?.width ?? Get.width) / aspectRatio) - 20,
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
            const SizedBox(width: 25),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: maxWidth / aspectRatio,
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
