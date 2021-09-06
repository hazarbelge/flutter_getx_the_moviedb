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
      height: height/1.6,
      child: Image.network(
        imageUrl,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}

/*class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, (Get.context?.height ?? Get.height) - 30);

    final Offset firstControlPoint = Offset((Get.context?.width ?? Get.width) / 4, Get.context?.height ?? Get.height);
    final Offset firstPoint = Offset((Get.context?.width ?? Get.width) / 2, Get.context?.height ?? Get.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstPoint.dx, firstPoint.dy);

    final Offset secondControlPoint = Offset((Get.context?.width ?? Get.width) - ((Get.context?.width ?? Get.width) / 4), Get.context?.height ?? Get.height);
    final Offset secondPoint = Offset(Get.context?.width ?? Get.width, (Get.context?.height ?? Get.height) - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondPoint.dx, secondPoint.dy);

    path.lineTo(Get.context?.width ?? Get.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}*/
