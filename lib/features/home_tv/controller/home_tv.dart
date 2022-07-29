import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/core/base/index.dart';
import 'package:flutter_getx_the_moviedb/core/theme/index.dart';
import 'package:flutter_getx_the_moviedb/features/home_tv/index.dart';
import 'package:get/get.dart';

class HomeTvScreenController extends BaseController<dynamic> {
  HomeTvScreenController();

  final RxInt currentIndex = 0.obs;

  final List<Widget> tabs = const <Widget>[
    AiringTodayTvSeriesTab(),
    OnTheAirTvSeriesTab(),
    PopularTvSeriesTab(),
    TopRatedTvSeriesTab(),
  ];

  void changeBrightness() {
    Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
    WidgetsBinding.instance.performReassemble();
  }

  void openEndDrawer(GlobalKey<ScaffoldState> _scaffoldKey) {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  Color getMyColor(int bottomBarIndex, int itemIndex) {
    Color color;
    if (bottomBarIndex != itemIndex) {
      if (Get.theme == Style.lightTheme) {
        color = Colors.white;
      } else {
        color = Colors.black26;
      }
    } else if (Get.theme == Style.lightTheme) {
      if (kIsWeb) {
        color = Colors.white;
      } else {
        color = Colors.transparent;
      }
    } else {
      color = Colors.white;
    }
    return color;
  }
}
