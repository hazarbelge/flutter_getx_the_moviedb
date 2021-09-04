import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    Matrix4? matrix4;
    final TransformationController _transformationController = TransformationController();
    return Scaffold(
      backgroundColor: Colors.black26,
      body: SizedBox(
        height: Get.context?.height ?? Get.height,
        width: double.infinity,
        child: InteractiveViewer(
          panEnabled: false,
          boundaryMargin: EdgeInsets.zero,
          minScale: 0.5,
          maxScale: 4,
          transformationController: _transformationController,
          onInteractionStart: (ScaleStartDetails details) {
            matrix4 = _transformationController.value;
          },
          onInteractionEnd: (ScaleEndDetails details) {
            _transformationController.value = matrix4 ?? _transformationController.value;
          },
          child: Center(
            child: Image.network(
              imageUrl,
              width: Get.context?.width ?? Get.width,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
