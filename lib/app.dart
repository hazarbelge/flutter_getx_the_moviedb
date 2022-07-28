import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/core/app/strings.dart';
import 'package:flutter_getx_the_moviedb/core/theme/index.dart';
import 'package:flutter_getx_the_moviedb/core/utils/index.dart';
import 'package:flutter_getx_the_moviedb/routes/index.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'ui/widgets/custom_widgets/index.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({
    Key? key,
  }) : super(key: key);

  static GlobalKey movieAppKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => KeyboardUtil.hideKeyboard(context),
      child: GetMaterialApp(
        key: movieAppKey,
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        translations: TranslationsUtil(),
        locale: TranslationsUtil.locale,
        fallbackLocale: TranslationsUtil.fallbackLocale,
        theme: Style.lightTheme,
        darkTheme: Style.darkTheme,
        themeMode: ThemeMode.dark,
        defaultTransition: Transition.fadeIn,
        getPages: AppPages.routes,
        initialRoute: AppRoutes.START,
        builder: (BuildContext context, Widget? widget) {
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            return CustomErrorScreen(errorDetails: errorDetails);
          };
          final MediaQueryData mediaQueryData = MediaQuery.of(context);
          return MediaQuery(
            data: mediaQueryData.copyWith(
              platformBrightness: Brightness.light,
              textScaleFactor: 1,
              alwaysUse24HourFormat: true,
              boldText: false,
            ),
            child: ResponsiveWrapper.builder(
              BouncingScrollWrapper.builder(context, widget!),
              maxWidth: 2460,
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
            ),
          );
        },
        enableLog: kDebugMode,
        logWriterCallback: (String text, {bool isError = false}) {
          debugPrint("GetXLog: $text");
        },
        navigatorObservers: <NavigatorObserver>[
          GetObserver(),
        ],
      ),
    );
  }
}
