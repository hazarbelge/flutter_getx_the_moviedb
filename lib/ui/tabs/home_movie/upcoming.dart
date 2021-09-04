import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/index.dart';
import '../../../models/index.dart';
import '../../../routes/index.dart';
import '../../../ui/widgets/index.dart';

class UpcomingMoviesTab extends GetView<UpcomingMoviesController> {
  const UpcomingMoviesTab({Key? key}) : super(key: key);

  Future<void> refreshPage() async {}

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => refreshPage(),
      child: SizedBox(
        height: Get.context?.height ?? Get.height,
        width: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                controller.obx(
                  (MovieWrapper? movieWrapper) {
                    return movieWrapper != null
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: movieWrapper.results?.length,
                            itemBuilder: (BuildContext context, int index) => CardListMovies(
                              image: 'https://image.tmdb.org/t/p/w185${movieWrapper.results?[index].posterPath}',
                              title: movieWrapper.results?[index].title ?? "",
                              vote: movieWrapper.results?[index].voteAverage ?? "",
                              releaseDate: movieWrapper.results?[index].releaseDate ?? "",
                              overview: movieWrapper.results?[index].overview ?? "",
                              genre: movieWrapper.results?[index].genreIds != null ? movieWrapper.results![index].genreIds!.take(3).map(createGenreContainer).toList() : <Widget>[],
                              onTap: () {
                                Get.rootDelegate.toNamed(
                                  AppRoutes.DETAIL_MOVIE,
                                  arguments: <String, dynamic>{
                                    'movie': movieWrapper.results?[index],
                                    'isMovie': true,
                                  },
                                );
                              },
                            ),
                          )
                        : const CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
