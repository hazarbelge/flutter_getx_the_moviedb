import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/index.dart';
import '../../providers/index.dart';
import '../../ui/widgets/index.dart';

class NowPlayingMoviesController extends SuperController<MovieWrapper?> {
  NowPlayingMoviesController({
    required this.homeMovieRepository,
  });

  final HomeMovieRepository homeMovieRepository;
  final ScrollController scrollController = ScrollController();
  final RxBool isLoading = false.obs;

  Future<void> pagination() async {
    if (scrollController.position.extentAfter < 400 && state != null && state!.totalPages != state!.page && !isLoading.value) {
      isLoading.value = true;
      CustomProgressIndicator.openLoadingDialog();
      final MovieWrapper? movieWrapper = await _getMovies();
      state!.results.addAll(movieWrapper!.results);
      state!.page = movieWrapper.page;
      update();
      CustomProgressIndicator.closeLoadingOverlay();
      isLoading.value = false;
    }
  }

  Future<MovieWrapper?> _getMovies() async {
    final Future<MovieWrapper?> future = homeMovieRepository.getNowPlayingMovie(
      query: <String, dynamic>{
        "page": state!.page + 1,
        "language": Get.locale?.languageCode ?? 'en-US',
      },
    );
    return future;
  }

  @override
  void onInit() {
    super.onInit();
    append(() => homeMovieRepository.getNowPlayingMovie);
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
