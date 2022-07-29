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
  final RxInt page = 1.obs;

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
        "page": page.value + 1,
      },
    );
    state!.results!.addAll(tvSeriesWrapper!.results!);
    page.value = tvSeriesWrapper.page!;
    update();

    await CustomProgressIndicator.closeLoadingOverlay();
    isLoading.value = false;
  }

  Future<TvSeriesWrapper?> _getInitialTvSeries() async {
    CustomProgressIndicator.openLoadingDialog();
    final TvSeriesWrapper? tvSeriesWrapper = await repository.getTopRatedTvSeries(
      query: <String, dynamic>{
        "page": 1,
      },
    );
    page.value = tvSeriesWrapper!.page!;
    await CustomProgressIndicator.closeLoadingOverlay();
    return tvSeriesWrapper;
  }

  Future<void> appendInitialTvSeries() async {
    append(() => _getInitialTvSeries);
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(pagination);
  }

  @override
  void onReady() {
    super.onReady();
    appendInitialTvSeries();
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.removeListener(pagination);
  }
}
