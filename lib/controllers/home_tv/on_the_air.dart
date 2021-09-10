import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/index.dart';
import '../../providers/index.dart';
import '../../ui/widgets/index.dart';

class OnTheAirTvSeriesController extends SuperController<TvSeriesWrapper?> {
  OnTheAirTvSeriesController({
    required this.homeTvRepository,
  });

  final HomeTvRepository homeTvRepository;
  final ScrollController scrollController = ScrollController();
  final RxBool isLoading = false.obs;

  void pagination() {
    if (scrollController.position.extentAfter < 400 && state != null && state!.totalPages != state!.page && !isLoading.value) {
      _getTvSeries();
    }
  }

  Future<void> _getTvSeries() async {
    isLoading.value = true;
    CustomProgressIndicator.openLoadingDialog();

    final TvSeriesWrapper? tvSeriesWrapper = await homeTvRepository.getOnTheAirTvSeries(
      query: <String, dynamic>{
        "page": state!.page + 1,
        "language": Get.locale?.languageCode ?? 'en-US',
      },
    );
    state!.results.addAll(tvSeriesWrapper!.results);
    state!.page = tvSeriesWrapper.page;
    update();

    CustomProgressIndicator.closeLoadingOverlay();
    isLoading.value = false;
  }

  Future<TvSeriesWrapper?> _getInitialTvSeries() async {
    final TvSeriesWrapper? tvSeriesWrapper = await homeTvRepository.getOnTheAirTvSeries(
      query: <String, dynamic>{
        "page": 1,
        "language": Get.locale?.languageCode ?? 'en-US',
      },
    );
    return tvSeriesWrapper;
  }

  @override
  void onInit() {
    super.onInit();
    append(() => _getInitialTvSeries);
    scrollController.addListener(pagination);
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.removeListener(pagination);
  }

  @override
  void onDetached() {
    debugPrint('onDetached called');
  }

  @override
  void onInactive() {
    debugPrint('onInactive called');
  }

  @override
  void onPaused() {
    debugPrint('onPaused called');
  }

  @override
  void onResumed() {
    debugPrint('onResumed called');
  }
}
