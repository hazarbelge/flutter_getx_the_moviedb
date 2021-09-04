import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/index.dart';
import '../../../models/index.dart';
import '../../../routes/index.dart';
import '../../../ui/widgets/index.dart';

class TopRatedMoviesTab extends GetView<TopRatedMoviesController> {
  const TopRatedMoviesTab({Key? key}) : super(key: key);

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
                        ? LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints boxConstraints) {
                        if (boxConstraints.maxWidth >= 1300) {
                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 60,
                              childAspectRatio: 1.75,
                            ),
                            itemCount: movieWrapper.results?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return CardListMovies(
                                image: 'https://image.tmdb.org/t/p/w185${movieWrapper.results?[index].posterPath}',
                                title: movieWrapper.results?[index].title ?? "",
                                vote: movieWrapper.results?[index].voteAverage ?? "",
                                releaseDate: movieWrapper.results?[index].releaseDate ?? "",
                                overview: movieWrapper.results?[index].overview ?? "",
                                genre: movieWrapper.results?[index].genreIds != null ? movieWrapper.results![index].genreIds!.take(3).map(createGenreContainer).toList() : <Widget>[],
                                onTap: () {
                                  Get.toNamed(
                                    AppRoutes.DETAIL,
                                    arguments: <String, dynamic>{
                                      'movie': movieWrapper.results?[index],
                                      'isMovie': true,
                                    },
                                  );
                                },
                              );
                            },
                          );
                        } else if (boxConstraints.maxWidth >= 800) {
                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              childAspectRatio: 1.75,
                            ),
                            itemCount: movieWrapper.results?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return CardListMovies(
                                image: 'https://image.tmdb.org/t/p/w185${movieWrapper.results?[index].posterPath}',
                                title: movieWrapper.results?[index].title ?? "",
                                vote: movieWrapper.results?[index].voteAverage ?? "",
                                releaseDate: movieWrapper.results?[index].releaseDate ?? "",
                                overview: movieWrapper.results?[index].overview ?? "",
                                genre: movieWrapper.results?[index].genreIds != null ? movieWrapper.results![index].genreIds!.take(3).map(createGenreContainer).toList() : <Widget>[],
                                onTap: () {
                                  Get.toNamed(
                                    AppRoutes.DETAIL,
                                    arguments: <String, dynamic>{
                                      'movie': movieWrapper.results?[index],
                                      'isMovie': true,
                                    },
                                  );
                                },
                              );
                            },
                          );
                        } else if (boxConstraints.maxWidth <= 350) {
                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 10,
                              childAspectRatio: 2,
                            ),
                            itemCount: movieWrapper.results?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                child: SizedBox(
                                  child: Row(
                                    children: <Widget>[
                                      Image.network(
                                        'https://image.tmdb.org/t/p/w185${movieWrapper.results?[index].posterPath}',
                                      ),
                                      const SizedBox(width: 10),
                                      Center(
                                        child: SizedBox(
                                          width: boxConstraints.maxWidth / 2,
                                          child: Text(
                                            movieWrapper.results?[index].title ?? "",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Get.toNamed(
                                    AppRoutes.DETAIL,
                                    arguments: <String, dynamic>{
                                      'movie': movieWrapper.results?[index],
                                      'isMovie': true,
                                    },
                                  );
                                },
                              );
                            },
                          );
                        } else {
                          return ListView.builder(
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
                                Get.toNamed(
                                  AppRoutes.DETAIL,
                                  arguments: <String, dynamic>{
                                    'movie': movieWrapper.results?[index],
                                    'isMovie': true,
                                  },
                                );
                              },
                            ),
                          );
                        }
                      },
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
