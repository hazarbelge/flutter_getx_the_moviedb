import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/index.dart';
import '../../../models/index.dart';
import '../../../routes/index.dart';
import '../../../ui/widgets/index.dart';

class TopRatedTvSeriesTab extends GetView<TopRatedTvSeriesController> {
  const TopRatedTvSeriesTab({Key? key}) : super(key: key);

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
                        ? ListView.builder(
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
