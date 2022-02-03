import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/models/index.dart';
import 'package:flutter_getx_the_moviedb/ui/home_movie/index.dart';
import 'package:flutter_getx_the_moviedb/ui/widgets/index.dart';
import 'package:get/get.dart';

class NowPlayingMoviesController extends SuperController<MovieWrapper?> {
  NowPlayingMoviesController({
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

    final MovieWrapper? movieWrapper = await homeMovieRepository.getNowPlayingMovie(
      query: <String, dynamic>{
        "page": state!.page + 1,
        "language": Get.locale?.languageCode ?? 'tr-TR',
      },
    );
    state!.results.addAll(movieWrapper!.results);
    state!.page = movieWrapper.page;
    update();

    CustomProgressIndicator.closeLoadingOverlay();
    isLoading.value = false;
  }

  Future<MovieWrapper?> _getInitialMovies() async {
    final MovieWrapper? movieWrapper = await homeMovieRepository.getNowPlayingMovie(
      query: <String, dynamic>{
        "page": 1,
        "language": Get.locale?.languageCode ?? 'tr-TR',
      },
    );
    return movieWrapper;
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint('$runtimeType onInit called');
    append(() => _getInitialMovies);
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
