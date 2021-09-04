import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/index.dart';
import '../../../models/index.dart';
import '../../../routes/index.dart';
import '../../../ui/widgets/index.dart';

class OnTheAirTvSeriesTab extends GetView<OnTheAirTvSeriesController> {
  const OnTheAirTvSeriesTab({Key? key}) : super(key: key);

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
                      (TvSeriesWrapper? tvSeriesWrapper) {
                    return tvSeriesWrapper != null
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
                            itemCount: tvSeriesWrapper.results?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return CardListTvSeries(
                                image: 'https://image.tmdb.org/t/p/w185${tvSeriesWrapper.results?[index].posterPath}',
                                title: tvSeriesWrapper.results?[index].name ?? "",
                                vote: tvSeriesWrapper.results?[index].voteAverage ?? "",
                                releaseDate: tvSeriesWrapper.results?[index].firstAirDate ?? "",
                                overview: tvSeriesWrapper.results?[index].overview ?? "",
                                genre: tvSeriesWrapper.results?[index].genreIds != null ? tvSeriesWrapper.results![index].genreIds!.take(3).map(createGenreContainer).toList() : <Widget>[],
                                onTap: () {
                                  Get.toNamed(
                                    AppRoutes.DETAIL,
                                    arguments: <String, dynamic>{
                                      'tvSeries': tvSeriesWrapper.results?[index],
                                      'isMovie': false,
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
                            itemCount: tvSeriesWrapper.results?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return CardListTvSeries(
                                image: 'https://image.tmdb.org/t/p/w185${tvSeriesWrapper.results?[index].posterPath}',
                                title: tvSeriesWrapper.results?[index].name ?? "",
                                vote: tvSeriesWrapper.results?[index].voteAverage ?? "",
                                releaseDate: tvSeriesWrapper.results?[index].firstAirDate ?? "",
                                overview: tvSeriesWrapper.results?[index].overview ?? "",
                                genre: tvSeriesWrapper.results?[index].genreIds != null ? tvSeriesWrapper.results![index].genreIds!.take(3).map(createGenreContainer).toList() : <Widget>[],
                                onTap: () {
                                  Get.toNamed(
                                    AppRoutes.DETAIL,
                                    arguments: <String, dynamic>{
                                      'tvSeries': tvSeriesWrapper.results?[index],
                                      'isMovie': false,
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
                            itemCount: tvSeriesWrapper.results?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                child: SizedBox(
                                  child: Row(
                                    children: <Widget>[
                                      Image.network(
                                        'https://image.tmdb.org/t/p/w185${tvSeriesWrapper.results?[index].posterPath}',
                                      ),
                                      const SizedBox(width: 10),
                                      Center(
                                        child: SizedBox(
                                          width: boxConstraints.maxWidth / 2,
                                          child: Text(
                                            tvSeriesWrapper.results?[index].name ?? "",
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
                                      'movie': tvSeriesWrapper.results?[index],
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
                            itemCount: tvSeriesWrapper.results?.length,
                            itemBuilder: (BuildContext context, int index) => CardListTvSeries(
                              image: 'https://image.tmdb.org/t/p/w185${tvSeriesWrapper.results?[index].posterPath}',
                              title: tvSeriesWrapper.results?[index].name ?? "",
                              vote: tvSeriesWrapper.results?[index].voteAverage ?? "",
                              releaseDate: tvSeriesWrapper.results?[index].firstAirDate ?? "",
                              overview: tvSeriesWrapper.results?[index].overview ?? "",
                              genre: tvSeriesWrapper.results?[index].genreIds != null ? tvSeriesWrapper.results![index].genreIds!.take(3).map(createGenreContainer).toList() : <Widget>[],
                              onTap: () {
                                Get.toNamed(
                                  AppRoutes.DETAIL,
                                  arguments: <String, dynamic>{
                                    'tvSeries': tvSeriesWrapper.results?[index],
                                    'isMovie': false,
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
