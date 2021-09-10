import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/index.dart';
import '../../providers/index.dart';
import '../../ui/widgets/index.dart';

class PopularMoviesController extends SuperController<MovieWrapper?> {
  PopularMoviesController({
    required this.homeMovieRepository,
  });

  final HomeMovieRepository homeMovieRepository;
  final ScrollController scrollController = ScrollController();
  final RxBool isLoading = false.obs;

  void pagination() {
    if (scrollController.position.extentAfter < 400 && state != null && state!.totalPages != state!.page && !isLoading.value) {
      _getMovies();
    }
  }

  Future<void> _getMovies() async {
    isLoading.value = true;
    CustomProgressIndicator.openLoadingDialog();

    final MovieWrapper? movieWrapper = await homeMovieRepository.getPopularMovie(
      query: <String, dynamic>{
        "page": state!.page + 1,
        "language": Get.locale?.languageCode ?? 'en-US',
      },
    );
    state!.results.addAll(movieWrapper!.results);
    state!.page = movieWrapper.page;
    update();

    CustomProgressIndicator.closeLoadingOverlay();
    isLoading.value = false;
  }

  Future<MovieWrapper?> _getInitialMovies() async {
    final MovieWrapper? movieWrapper = await homeMovieRepository.getPopularMovie(
      query: <String, dynamic>{
        "page": 1,
        "language": Get.locale?.languageCode ?? 'en-US',
      },
    );
    return movieWrapper;
  }

  @override
  void onInit() {
    super.onInit();
    append(() => _getInitialMovies);
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
