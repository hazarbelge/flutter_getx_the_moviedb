import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/features/home_tv/index.dart';
import 'package:flutter_getx_the_moviedb/features/widgets/index.dart';
import 'package:flutter_getx_the_moviedb/models/index.dart';
import 'package:flutter_getx_the_moviedb/ui/widgets/custom_widgets/index.dart';
import 'package:get/get.dart';

class PopularTvSeriesTab extends GetView<PopularTvSeriesController> {
  const PopularTvSeriesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return CustomRefreshIndicator(
      onRefresh: controller.appendInitialTvSeries,
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
                  onError: (String? msg) => const SizedBox(),
                  onEmpty: const SizedBox(),
                  onLoading: const SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
