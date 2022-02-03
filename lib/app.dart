import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/routes/index.dart';
import 'package:flutter_getx_the_moviedb/util/index.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({
    Key? key,
  }) : super(key: key);

  static GlobalKey movieAppKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      key: movieAppKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter The Movie DB',
      builder: (BuildContext context, Widget? widget) {
        return ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: const <ResponsiveBreakpoint>[
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(
            color: const Color(0xFFF5F5F5),
          ),
        );
      },
      translations: GetTranslations(),
      locale: Get.deviceLocale,
      fallbackLocale: GetTranslations.fallbackLocale,
      theme: Style.lightTheme,
      darkTheme: Style.darkTheme,
      themeMode: ThemeMode.dark,
      defaultTransition: Transition.fadeIn,
      getPages: AppPages.routes,
      initialRoute: AppRoutes.START,
      enableLog: true,
      logWriterCallback: (String text, {bool isError = false}) {
        debugPrint("GetXLog: $text");
      },
      navigatorObservers: <NavigatorObserver>[
        GetObserver(),
      ],
    );
  }
}
