import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/index.dart';
import '../../ui/tabs/home_movie/index.dart';
import '../../ui/widgets/index.dart';
import '../../util/index.dart';

class HomeMovieScreen extends GetView<HomeMovieScreenController> {
  const HomeMovieScreen({
    Key? key,
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    const List<Widget> tabs = <Widget>[
      NowPlayingMoviesTab(),
      PopularMoviesTab(),
      TopRatedMoviesTab(),
      UpcomingMoviesTab(),
    ];
    return Obx(
      () => Scaffold(
        appBar: const CustomAppBar(),
        body: tabs[controller.currentIndex.value],
        bottomNavigationBar: ConvexAppBar(
          color: Colors.grey,
          backgroundColor: darkAccentColor,
          style: TabStyle.react,
          onTap: (int index) => controller.currentIndex.value != index ? controller.currentIndex.value = index : null,
          initialActiveIndex: controller.currentIndex.value,
          items: <TabItem<SvgPicture>>[
            TabItem<SvgPicture>(
              title: 'movies.now_playing.icon'.tr,
              icon: SvgPicture.asset(
                'assets/icons/app_icon.svg',
                colorBlendMode: BlendMode.srcATop,
                width: 24,
                height: 24,
                color: getMyColor(controller.currentIndex.value, 0),
              ),
            ),
            TabItem<SvgPicture>(
              title: 'movies.popular.icon'.tr,
              icon: SvgPicture.asset(
                'assets/icons/app_icon.svg',
                colorBlendMode: BlendMode.srcATop,
                width: 24,
                height: 24,
                color: getMyColor(controller.currentIndex.value, 1),
              ),
            ),
            TabItem<SvgPicture>(
              title: 'movies.top_rated.icon'.tr,
              icon: SvgPicture.asset(
                'assets/icons/app_icon.svg',
                colorBlendMode: BlendMode.srcATop,
                width: 24,
                height: 24,
                color: getMyColor(controller.currentIndex.value, 2),
              ),
            ),
            TabItem<SvgPicture>(
              title: 'movies.upcoming.icon'.tr,
              icon: SvgPicture.asset(
                'assets/icons/app_icon.svg',
                colorBlendMode: BlendMode.srcATop,
                width: 24,
                height: 24,
                color: getMyColor(controller.currentIndex.value, 3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}