import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/index.dart';
import '../../ui/tabs/home_tv/index.dart';
import '../../ui/widgets/index.dart';
import '../../util/index.dart';

class HomeTvScreen extends GetView<HomeTvScreenController> {
  const HomeTvScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isDesktop || GetPlatform.isWeb) {
      return const HomeTvDesktopWebScaffold();
    } else {
      return const HomeTvMobileScaffold();
    }
  }
}

class HomeTvDesktopWebScaffold extends GetView<HomeTvScreenController> {
  const HomeTvDesktopWebScaffold({Key? key}) : super(key: key);

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

  List<Widget> navigation() {
    return <Widget>[
      InkWell(
        child: Text(
          'tv_series.airing_today_tv.icon'.tr,
          style: TextStyle(
            fontSize: 16,
            color: controller.currentIndex.value != 0 ? Colors.white : Colors.orange,
          ),
        ),
        onTap: () => controller.currentIndex.value != 0 ? controller.currentIndex.value = 0 : null,
      ),
      InkWell(
        child: Text(
          'tv_series.on_the_air_tv.icon'.tr,
          style: TextStyle(
            fontSize: 16,
            color: controller.currentIndex.value != 1 ? Colors.white : Colors.orange,
          ),
        ),
        onTap: () => controller.currentIndex.value != 1 ? controller.currentIndex.value = 1 : null,
      ),
      InkWell(
        child: Text(
          'tv_series.popular_tv.icon'.tr,
          style: TextStyle(
            fontSize: 16,
            color: controller.currentIndex.value != 2 ? Colors.white : Colors.orange,
          ),
        ),
        onTap: () => controller.currentIndex.value != 2 ? controller.currentIndex.value = 2 : null,
      ),
      InkWell(
        child: Text(
          'tv_series.top_rated_tv.icon'.tr,
          style: TextStyle(
            fontSize: 16,
            color: controller.currentIndex.value != 3 ? Colors.white : Colors.orange,
          ),
        ),
        onTap: () => controller.currentIndex.value != 3 ? controller.currentIndex.value = 3 : null,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    const List<Widget> tabs = <Widget>[
      AiringTodayTvSeriesTab(),
      OnTheAirTvSeriesTab(),
      PopularTvSeriesTab(),
      TopRatedTvSeriesTab(),
    ];
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    return Obx(
      () => Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: darkAccentColor,
          title: width >= 500
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: navigation(),
                )
              : const SizedBox(),
          centerTitle: true,
          automaticallyImplyLeading: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_outlined),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                WidgetsBinding.instance!.performReassemble();
              },
              icon: Icon(Get.isDarkMode ? Icons.wb_incandescent : Icons.wb_incandescent_outlined),
            ),
            IconButton(
              onPressed: () {
                Get.updateLocale(Get.locale! == const Locale("tr", "TR") ? const Locale("en", "US") : const Locale("tr", "TR"));
              },
              icon: Text(Get.locale != null ? Get.locale!.languageCode.toUpperCase() : "TR"),
            ),
            if (width < 500)
              IconButton(
                onPressed: () {
                  _scaffoldKey.currentState!.openEndDrawer();
                },
                icon: const Icon(Icons.menu),
              )
          ],
        ),
        body: tabs[controller.currentIndex.value],
        endDrawer: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: navigation(),
        ),
        endDrawerEnableOpenDragGesture: false,
      ),
    );
  }
}

class HomeTvMobileScaffold extends GetView<HomeTvScreenController> {
  const HomeTvMobileScaffold({Key? key}) : super(key: key);

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
      AiringTodayTvSeriesTab(),
      OnTheAirTvSeriesTab(),
      PopularTvSeriesTab(),
      TopRatedTvSeriesTab(),
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
              title: 'tv_series.airing_today_tv.icon'.tr,
              icon: SvgPicture.asset(
                'assets/icons/app_icon.svg',
                colorBlendMode: BlendMode.srcATop,
                width: 24,
                height: 24,
                color: getMyColor(controller.currentIndex.value, 0),
              ),
            ),
            TabItem<SvgPicture>(
              title: 'tv_series.on_the_air_tv.icon'.tr,
              icon: SvgPicture.asset(
                'assets/icons/app_icon.svg',
                colorBlendMode: BlendMode.srcATop,
                width: 24,
                height: 24,
                color: getMyColor(controller.currentIndex.value, 1),
              ),
            ),
            TabItem<SvgPicture>(
              title: 'tv_series.popular_tv.icon'.tr,
              icon: SvgPicture.asset(
                'assets/icons/app_icon.svg',
                colorBlendMode: BlendMode.srcATop,
                width: 24,
                height: 24,
                color: getMyColor(controller.currentIndex.value, 2),
              ),
            ),
            TabItem<SvgPicture>(
              title: 'tv_series.top_rated_tv.icon'.tr,
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
