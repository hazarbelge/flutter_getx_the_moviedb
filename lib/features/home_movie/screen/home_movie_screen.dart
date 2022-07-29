import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/core/theme/index.dart';
import 'package:flutter_getx_the_moviedb/core/utils/index.dart';
import 'package:flutter_getx_the_moviedb/features/home_movie/index.dart';
import 'package:flutter_getx_the_moviedb/ui/widgets/custom_widgets/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeMovieScreen extends GetView<HomeMovieScreenController> {
  const HomeMovieScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isDesktop || GetPlatform.isWeb) {
      return const HomeMovieDesktopWebScaffold();
    } else {
      return const HomeMovieMobileScaffold();
    }
  }
}

class HomeMovieDesktopWebScaffold extends GetView<HomeMovieScreenController> {
  const HomeMovieDesktopWebScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    const List<Widget> tabs = <Widget>[
      NowPlayingMoviesTab(),
      PopularMoviesTab(),
      TopRatedMoviesTab(),
      UpcomingMoviesTab(),
    ];
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    return Obx(
      () => Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: darkAccentColor,
          title: width >= 500 ? const NavigationRow() : const SizedBox(),
          centerTitle: true,
          automaticallyImplyLeading: true,
          leading: IconButton(
            onPressed: Get.back,
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
          actions: <Widget>[
            /*IconButton(
              onPressed: controller.changeBrightness,
              icon: Icon(Get.isDarkMode ? Icons.wb_incandescent : Icons.wb_incandescent_outlined),
            ),*/
            if (width < 500)
              IconButton(
                onPressed: () => controller.openEndDrawer(_scaffoldKey),
                icon: const Icon(Icons.menu),
              )
          ],
        ),
        body: tabs[controller.currentIndex.value],
        endDrawer: const NavigationColumn(),
        endDrawerEnableOpenDragGesture: false,
      ),
    );
  }
}

class HomeMovieMobileScaffold extends GetView<HomeMovieScreenController> {
  const HomeMovieMobileScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: const CustomAppBar(),
        body: controller.tabs[controller.currentIndex.value],
        bottomNavigationBar: ConvexAppBar(
          color: Colors.grey,
          backgroundColor: darkAccentColor,
          style: TabStyle.react,
          onTap: (int index) => controller.currentIndex.value != index ? controller.currentIndex.value = index : null,
          initialActiveIndex: controller.currentIndex.value,
          items: <TabItem<SvgPicture>>[
            TabItem<SvgPicture>(
              title: 'movies.now_playing.icon'.tr,
              icon: ThemeIcons(color: controller.getMyColor(controller.currentIndex.value, 0)).theMovieDBLogo,
            ),
            TabItem<SvgPicture>(
              title: 'movies.popular.icon'.tr,
              icon: ThemeIcons(color: controller.getMyColor(controller.currentIndex.value, 1)).theMovieDBLogo,
            ),
            TabItem<SvgPicture>(
              title: 'movies.top_rated.icon'.tr,
              icon: ThemeIcons(color: controller.getMyColor(controller.currentIndex.value, 2)).theMovieDBLogo,
            ),
            TabItem<SvgPicture>(
              title: 'movies.upcoming.icon'.tr,
              icon: ThemeIcons(color: controller.getMyColor(controller.currentIndex.value, 3)).theMovieDBLogo,
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationRow extends GetView<HomeMovieScreenController> {
  const NavigationRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InkWell(
            child: Text(
              'movies.now_playing.icon'.tr,
              style: TextStyle(
                fontSize: 16,
                color: controller.currentIndex.value != 0 ? Colors.white : Colors.orange,
              ),
            ),
            onTap: () => controller.currentIndex.value != 0 ? controller.currentIndex.value = 0 : null,
          ),
          InkWell(
            child: Text(
              'movies.popular.icon'.tr,
              style: TextStyle(
                fontSize: 16,
                color: controller.currentIndex.value != 1 ? Colors.white : Colors.orange,
              ),
            ),
            onTap: () => controller.currentIndex.value != 1 ? controller.currentIndex.value = 1 : null,
          ),
          InkWell(
            child: Text(
              'movies.top_rated.icon'.tr,
              style: TextStyle(
                fontSize: 16,
                color: controller.currentIndex.value != 2 ? Colors.white : Colors.orange,
              ),
            ),
            onTap: () => controller.currentIndex.value != 2 ? controller.currentIndex.value = 2 : null,
          ),
          InkWell(
            child: Text(
              'movies.upcoming.icon'.tr,
              style: TextStyle(
                fontSize: 16,
                color: controller.currentIndex.value != 3 ? Colors.white : Colors.orange,
              ),
            ),
            onTap: () => controller.currentIndex.value != 3 ? controller.currentIndex.value = 3 : null,
          ),
        ],
      ),
    );
  }
}

class NavigationColumn extends GetView<HomeMovieScreenController> {
  const NavigationColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InkWell(
            child: Text(
              'movies.now_playing.icon'.tr,
              style: TextStyle(
                fontSize: 16,
                color: controller.currentIndex.value != 0 ? Colors.white : Colors.orange,
              ),
            ),
            onTap: () => controller.currentIndex.value != 0 ? controller.currentIndex.value = 0 : null,
          ),
          InkWell(
            child: Text(
              'movies.popular.icon'.tr,
              style: TextStyle(
                fontSize: 16,
                color: controller.currentIndex.value != 1 ? Colors.white : Colors.orange,
              ),
            ),
            onTap: () => controller.currentIndex.value != 1 ? controller.currentIndex.value = 1 : null,
          ),
          InkWell(
            child: Text(
              'movies.top_rated.icon'.tr,
              style: TextStyle(
                fontSize: 16,
                color: controller.currentIndex.value != 2 ? Colors.white : Colors.orange,
              ),
            ),
            onTap: () => controller.currentIndex.value != 2 ? controller.currentIndex.value = 2 : null,
          ),
          InkWell(
            child: Text(
              'movies.upcoming.icon'.tr,
              style: TextStyle(
                fontSize: 16,
                color: controller.currentIndex.value != 3 ? Colors.white : Colors.orange,
              ),
            ),
            onTap: () => controller.currentIndex.value != 3 ? controller.currentIndex.value = 3 : null,
          ),
        ],
      ),
    );
  }
}
