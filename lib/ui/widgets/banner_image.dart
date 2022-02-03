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
    return SizedBox(
      width: double.infinity,
      height: height / 1.6,
      child: Image.network(
        imageUrl,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
