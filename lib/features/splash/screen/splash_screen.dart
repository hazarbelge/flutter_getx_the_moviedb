import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/core/theme/index.dart';
import 'package:flutter_getx_the_moviedb/core/utils/index.dart';
import 'package:flutter_getx_the_moviedb/features/splash/index.dart';
import 'package:flutter_getx_the_moviedb/models/index.dart';
import 'package:flutter_getx_the_moviedb/routes/index.dart';
import 'package:flutter_getx_the_moviedb/ui/widgets/base_widgets/index.dart';
import 'package:flutter_getx_the_moviedb/ui/widgets/custom_widgets/index.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashScreenController> {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        height: height,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            SplashIcon(),
            HomeButtons(),
          ],
        ),
      ),
    );
  }
}

class SplashIcon extends GetView<SplashScreenController> {
  const SplashIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(GlobalVariables.images.appLogoPath),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'app.title'.tr,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeButtons extends GetView<SplashScreenController> {
  const HomeButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        height: 300,
        width: width,
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
                    child: BaseButton(
                      backgroundColor: ThemeColors.primaryColor,
                      borderRadius: 6,
                      onPressed: () => Get.toNamed(AppRoutes.HOME_MOVIE),
                      text: 'app.movies.title'.tr,
                      textColor: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  const Spacer(flex: 2),
                  SizedBox(
                    height: 60,
                    width: 150,
                    child: BaseButton(
                      backgroundColor: ThemeColors.primaryColor,
                      borderRadius: 6,
                      onPressed: () => Get.toNamed(AppRoutes.HOME_TV),
                      text: 'app.tv_series.title'.tr,
                      textColor: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  const Spacer(flex: 2),
                  SizedBox(
                    height: 60,
                    width: 150,
                    child: BaseDropdownMenu<String>(
                      value: LanguageHelper.getLanguageCode() == "tr" ? "Türkçe" : "English",
                      itemList: const <String>["Türkçe", "English"],
                      onChanged: (String? val) {
                        if (val != null) {
                          Get.updateLocale(Locale(val == "Türkçe" ? "tr" : "en", val == "Türkçe" ? "TR" : "US"));
                          LanguageHelper.languageSave();
                        }
                      },
                    ),
                  ),
                  const Spacer(flex: 3),
                  SizedBox(
                    height: 60,
                    width: Get.context?.width ?? Get.width,
                    child: Center(
                      child: Text(
                        state?.guestSessionId ?? "",
                        style: const TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w300,
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
