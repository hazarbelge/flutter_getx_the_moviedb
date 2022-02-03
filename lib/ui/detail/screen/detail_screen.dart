import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/theme/index.dart';
import 'package:flutter_getx_the_moviedb/ui/detail/index.dart';
import 'package:flutter_getx_the_moviedb/ui/widgets/index.dart';
import 'package:get/get.dart';

class DetailScreen extends GetView<DetailPageController> {
  const DetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: controller.isMovie == null
              ? const SizedBox()
              : (controller.isMovie ?? false)
                  ? Column(
                      children: <Widget>[
                        HeaderDetail(
                          title: controller.movie!.title ?? "",
                          imageBanner: 'https://image.tmdb.org/t/p/original${controller.movie!.backdropPath ?? ""}',
                          imagePoster: 'https://image.tmdb.org/t/p/w185${controller.movie!.posterPath ?? ""}',
                          rating: double.parse(controller.movie!.voteAverage ?? "0"),
                          genre: controller.movie?.genreIds?.take(3).map(createGenreContainer).toList() ?? <Widget>[],
                          id: controller.movie!.id,
                          isMovie: true,
                        ),
                        const DetailTabNavigation(),
                        SizedBoxes.h50,
                      ],
                    )
                  : Column(
                      children: <Widget>[
                        HeaderDetail(
                          title: controller.tvSeries!.name ?? "",
                          imageBanner: 'https://image.tmdb.org/t/p/original${controller.tvSeries!.backdropPath ?? ""}',
                          imagePoster: 'https://image.tmdb.org/t/p/w185${controller.tvSeries!.posterPath ?? ""}',
                          rating: double.parse(controller.tvSeries!.voteAverage ?? "0"),
                          genre: controller.tvSeries?.genreIds?.take(3).map(createGenreContainer).toList() ?? <Widget>[],
                          id: controller.tvSeries!.id,
                          isMovie: false,
                        ),
                        const DetailTabNavigation(),
                        SizedBoxes.h50,
                      ],
                    ),
        ),
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
