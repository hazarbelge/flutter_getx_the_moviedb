import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/core/base/index.dart';
import 'package:flutter_getx_the_moviedb/features/home_tv/index.dart';
import 'package:flutter_getx_the_moviedb/models/index.dart';
import 'package:flutter_getx_the_moviedb/ui/widgets/custom_widgets/index.dart';
import 'package:get/get.dart';

class TopRatedTvSeriesController extends BaseRepositoryController<HomeTvRepository, HomeTvProvider, TvSeriesWrapper?> {
  TopRatedTvSeriesController({
    required this.homeTvRepository,
  }) : super(repository: homeTvRepository);

  final HomeTvRepository homeTvRepository;
  final ScrollController scrollController = ScrollController();
  final RxBool isLoading = false.obs;

  void pagination() {
    if (scrollController.position.extentAfter < 500 && state != null && state!.totalPages != 0 && state!.totalPages != state!.page && !isLoading.value) {
      _getTvSeries();
    }
  }

  Future<void> _getTvSeries() async {
    isLoading.value = true;
    CustomProgressIndicator.openLoadingDialog();

    final TvSeriesWrapper? tvSeriesWrapper = await repository.getTopRatedTvSeries(
      query: <String, dynamic>{
        "page": state!.page! + 1,
      },
    );
    state!.results!.addAll(tvSeriesWrapper!.results!);
    state!.page = tvSeriesWrapper.page;
    update();

    await CustomProgressIndicator.closeLoadingOverlay();
    isLoading.value = false;
  }

  Future<TvSeriesWrapper?> getInitialTvSeries() async {
    CustomProgressIndicator.openLoadingDialog();
    final TvSeriesWrapper? tvSeriesWrapper = await repository.getTopRatedTvSeries(
      query: <String, dynamic>{
        "page": 1,
      },
    );
    await CustomProgressIndicator.closeLoadingOverlay();
    return tvSeriesWrapper;
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(pagination);
  }

  @override
  void onReady() {
    super.onReady();
    append(() => getInitialTvSeries);
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.removeListener(pagination);
  }
}
