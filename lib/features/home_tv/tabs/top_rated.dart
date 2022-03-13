import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/features/home_tv/index.dart';
import 'package:flutter_getx_the_moviedb/features/widgets/index.dart';
import 'package:flutter_getx_the_moviedb/models/index.dart';
import 'package:get/get.dart';

class TopRatedTvSeriesTab extends GetView<TopRatedTvSeriesController> {
  const TopRatedTvSeriesTab({Key? key}) : super(key: key);

  Future<void> refreshPage() async {}

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return RefreshIndicator(
      onRefresh: refreshPage,
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            controller: controller.scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                controller.obx(
                  (TvSeriesWrapper? tvSeriesWrapper) {
                    if (tvSeriesWrapper != null) {
                      return ProductList(
                        productList: tvSeriesWrapper.results,
                        isMovie: false,
                      );
                    } else {
                      return const SizedBox();
                    }
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
