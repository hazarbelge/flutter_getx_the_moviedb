import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/features/detail/index.dart';
import 'package:flutter_getx_the_moviedb/features/widgets/index.dart';
import 'package:get/get.dart';
import 'package:nil/nil.dart';

class DetailScreen extends GetView<DetailPageController> {
  const DetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: controller.isMovie == null
                  ? nil
                  : (controller.isMovie ?? false)
                      ? Column(
                          children: <Widget>[
                            HeaderDetail(
                              title: controller.movie!.title ?? "",
                              imageBanner: 'https://image.tmdb.org/t/p/original${controller.movie!.backdropPath ?? ""}',
                              imagePoster: 'https://image.tmdb.org/t/p/w185${controller.movie!.posterPath ?? ""}',
                              rating: double.parse(controller.movie!.voteAverage ?? "0"),
                              genre: controller.movie?.genres?.map(createGenreContainer).toList() ?? <Widget>[],
                              id: controller.movie!.id!,
                              isMovie: true,
                            ),
                            const DetailTabNavigation(),
                            const SizedBox(height: 50),
                          ],
                        )
                      : Column(
                          children: <Widget>[
                            HeaderDetail(
                              title: controller.tvSeries!.name ?? "",
                              imageBanner: 'https://image.tmdb.org/t/p/original${controller.tvSeries!.backdropPath ?? ""}',
                              imagePoster: 'https://image.tmdb.org/t/p/w185${controller.tvSeries!.posterPath ?? ""}',
                              rating: double.parse(controller.tvSeries!.voteAverage ?? "0"),
                              genre: controller.tvSeries?.genres?.map(createGenreContainer).toList() ?? <Widget>[],
                              id: controller.tvSeries!.id!,
                              isMovie: false,
                            ),
                            const DetailTabNavigation(),
                            const SizedBox(height: 50),
                          ],
                        ),
            ),
          ),
          Positioned(
            top: 50,
            left: 15,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 36,
                color: Colors.white,
              ),
              onPressed: Get.back,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailTabNavigation extends GetView<DetailPageController> {
  const DetailTabNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _detailTabs = <Widget>[
      Overview(
        overview: controller.isMovie != null
            ? controller.isMovie!
                ? controller.movie!.overview ?? ""
                : controller.tvSeries!.overview ?? ""
            : "",
      ),
    ];
    final Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          width: size.width,
          height: 70,
          color: Get.isDarkMode ? Colors.white12 : Colors.grey[200],
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: ((size.width - (_detailTabs.length - 1 * 15)) / _detailTabs.length) - 44,
                height: 50,
                child: GestureDetector(
                  onTap: () {
                    if (controller.currentIndex.value != 0) {
                      controller.currentIndex.value = 0;
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Get.isDarkMode ? Colors.white12 : Colors.white70,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Overview",
                        style: TextStyle(
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Obx(() => _detailTabs[controller.currentIndex.value]),
          ),
        ),
      ],
    );
  }
}
