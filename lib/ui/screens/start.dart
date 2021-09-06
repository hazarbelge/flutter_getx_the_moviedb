import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/models/session_data.dart';
import 'package:flutter_getx_the_moviedb/ui/widgets/index.dart';
import 'package:get/get.dart';

import '../../controllers/index.dart';
import '../../routes/index.dart';
import '../../util/index.dart';

class StartScreen extends GetView<StartScreenController> {
  const StartScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            StartIcon(),
            HomeButtons(),
          ],
        ),
      ),
    );
  }
}

class StartIcon extends GetView<StartScreenController> {
  const StartIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 300,
      width: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.network(Url.appLogoUrl),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'app.title'.tr,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeButtons extends GetView<StartScreenController> {
  const HomeButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 300,
        width: Get.context?.width ?? Get.width,
        child: controller.obx(
          (SessionData? state) {
            if (state?.guestSessionId != null) {
              CustomProgressIndicator.closeLoadingOverlay();
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 60,
                    width: 150,
                    child: TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) => darkAccentColor)),
                      onPressed: () {
                        Get.toNamed(AppRoutes.HOME_MOVIE);
                      },
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'app.movies.title'.tr,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 60,
                    width: 150,
                    child: TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) => darkAccentColor)),
                      onPressed: () {
                        Get.toNamed(AppRoutes.HOME_TV);
                      },
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'app.tv_series.title'.tr,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(flex: 3),
                  SizedBox(
                    height: 100,
                    width: Get.context?.width ?? Get.width,
                    child: Center(
                      child: Text(
                        state?.guestSessionId ?? "",
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w300,
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              CustomProgressIndicator.openLoadingDialog();
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
