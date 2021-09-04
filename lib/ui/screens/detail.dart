import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/index.dart';
import '../widgets/index.dart';

class DetailPage extends GetView<DetailPageController> {
  const DetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            if (controller.isMovie == null)
              const SizedBox()
            else if (controller.isMovie!)
              Column(
                children: <Widget>[
                  HeaderDetail(
                    title: controller.movie!.title ?? "",
                    imageBanner: 'https://image.tmdb.org/t/p/original${controller.movie!.backdropPath ?? ""}',
                    imagePoster: 'https://image.tmdb.org/t/p/w185${controller.movie!.posterPath ?? ""}',
                    rating: double.parse(controller.movie!.voteAverage ?? "0"),
                    genre: controller.movie!.genreIds?.take(3).map(createGenreContainer).toList() ?? <Widget>[],
                    movieId: controller.movie!.id,
                    isMovie: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Overview(
                      overview: controller.movie!.overview ?? "",
                    ),
                  ),
                  const SizedBox(height: 50.0),
                ],
              )
            else
              Column(
                children: <Widget>[
                  HeaderDetail(
                    title: controller.tvSeries!.name ?? "",
                    imageBanner: 'https://image.tmdb.org/t/p/original${controller.tvSeries!.backdropPath ?? ""}',
                    imagePoster: 'https://image.tmdb.org/t/p/w185${controller.tvSeries!.posterPath ?? ""}',
                    rating: double.parse(controller.tvSeries!.voteAverage ?? "0"),
                    genre: controller.tvSeries!.genreIds?.take(3).map(createGenreContainer).toList() ?? <Widget>[],
                    movieId: controller.tvSeries!.id,
                    isMovie: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Overview(
                      overview: controller.tvSeries!.overview ?? "",
                    ),
                  ),
                  const SizedBox(height: 50.0),
                ],
              ),
            Positioned(
              top: 20,
              left: 5,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, size: 36),
                onPressed: () => Get.back(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
