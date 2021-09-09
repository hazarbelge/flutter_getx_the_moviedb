import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/index.dart';
import '../../providers/index.dart';
import '../../ui/widgets/index.dart';

class UpcomingMoviesController extends SuperController<MovieWrapper?> {
  UpcomingMoviesController({
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

    final MovieWrapper? movieWrapper = await homeMovieRepository.getUpcomingMovie(
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

  @override
  void onInit() {
    super.onInit();
    append(() => homeMovieRepository.getUpcomingMovie);
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
