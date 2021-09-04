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
            Column(
              children: <Widget>[
                HeaderDetail(
                  title: (controller.isMovie ?? true) ? controller.movie!.title ?? "" : controller.tvSeries!.name ?? "",
                  imageBanner: 'https://image.tmdb.org/t/p/original${(controller.isMovie ?? true) ? controller.movie!.backdropPath ?? "" : controller.tvSeries!.backdropPath ?? ""}',
                  imagePoster: 'https://image.tmdb.org/t/p/w185${(controller.isMovie ?? true) ? controller.movie!.posterPath ?? "" : controller.tvSeries!.posterPath ?? ""}',
                  rating: double.parse((controller.isMovie ?? true) ? controller.movie!.voteAverage ?? "0" : controller.tvSeries!.voteAverage ?? "0"),
                  genre: (controller.isMovie ?? true) ? controller.movie!.genreIds!.take(3).map(createGenreContainer).toList() : controller.tvSeries!.genreIds!.take(3).map(createGenreContainer).toList(),
                  movieId: (controller.isMovie ?? true) ? controller.movie!.id : controller.tvSeries!.id,
                  isMovie: controller.isMovie ?? true,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Overview(
                    overview: (controller.isMovie ?? true) ? controller.movie!.overview ?? "" : controller.tvSeries!.overview ?? "",
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
