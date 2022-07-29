import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/features/home_movie/index.dart';
import 'package:flutter_getx_the_moviedb/features/widgets/index.dart';
import 'package:flutter_getx_the_moviedb/models/index.dart';
import 'package:flutter_getx_the_moviedb/ui/widgets/custom_widgets/index.dart';
import 'package:get/get.dart';

class TopRatedMoviesTab extends GetView<TopRatedMoviesController> {
  const TopRatedMoviesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return CustomRefreshIndicator(
      onRefresh: controller.appendInitialMovies,
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: controller.scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                controller.obx(
                  (MovieWrapper? movieWrapper) {
                    if (movieWrapper != null) {
                      return ProductList(
                        productList: movieWrapper.results,
                        isMovie: true,
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
