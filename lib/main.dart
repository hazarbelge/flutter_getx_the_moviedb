import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/routes/index.dart';
import 'package:flutter_getx_the_moviedb/util/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> initServices() async {
  debugPrint('Starting GetX Services...');
  await GetStorage.init();
  await Get.putAsync(() => GlobalVariablesService().init());
  debugPrint('All GetX Services Started...');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();

  runApp(
    DevicePreview(
      enabled: false,
      builder: (BuildContext context) => const MovieApp(),
    ),
  );
}

class MovieApp extends StatelessWidget {
  const MovieApp({
    Key? key,
  }) : super(key: key);

  static GlobalKey movieAppKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(410, 840),
      builder: () {
        return GetMaterialApp(
          key: movieAppKey,
          debugShowCheckedModeBanner: false,
          title: 'Flutter The Movie DB',
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
      },
    );
  }
}
