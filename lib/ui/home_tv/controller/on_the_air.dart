import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/models/index.dart';
import 'package:flutter_getx_the_moviedb/ui/home_tv/index.dart';
import 'package:flutter_getx_the_moviedb/ui/widgets/index.dart';
import 'package:get/get.dart';

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
    debugPrint('$runtimeType onInit called');
    append(() => _getInitialTvSeries);
    scrollController.addListener(pagination);
  }

  @override
  void onReady() {
    super.onReady();
    debugPrint('$runtimeType onReady called');
  }

  @override
  void onClose() {
    super.onClose();
    debugPrint('$runtimeType onClose called');
    scrollController.removeListener(pagination);
  }

  @override
  void onDetached() {
    debugPrint('$runtimeType onDetached called');
  }

  @override
  void onInactive() {
    debugPrint('$runtimeType onInactive called');
  }

  @override
  void onPaused() {
    debugPrint('$runtimeType onPaused called');
  }

  @override
  void onResumed() {
    debugPrint('$runtimeType onResumed called');
  }
}
