import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomProgressIndicator {
  static bool isShowing = false;

  static void closeLoadingOverlay() {
    if (CustomProgressIndicator.isShowing) {
      Get.until((Route<dynamic> route) => !Get.isDialogOpen!);
    }
    CustomProgressIndicator.isShowing = false;
  }

  static void openLoadingDialog() {
    CustomProgressIndicator.isShowing = true;
    Get.dialog(
      const LoadingOverlay(),
      barrierDismissible: false,
    );
  }
}

class LoadingOverlay extends StatefulWidget {
  const LoadingOverlay({Key? key}) : super(key: key);

  @override
  _LoadingOverlayState createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150000),
      lowerBound: 10,
      upperBound: 20,
      vsync: this,
    );
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: SizedBox(
          height: Get.context?.height ?? Get.height,
          width: Get.context?.width ?? Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RotationTransition(
                turns: Tween<double>(begin: 0.0, end: 10.0).animate(_controller),
                child: Center(
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints boxConstraints) {
                      if (Get.context?.isTablet ?? Get.width >= 700) {
                        return SizedBox(
                          height: 90,
                          width: 90,
                          child: SvgPicture.asset("assets/icons/app_icon.svg"),
                        );
                      } else {
                        return SizedBox(
                          height: 50,
                          width: 50,
                          child: SvgPicture.asset("assets/icons/app_icon.svg"),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
