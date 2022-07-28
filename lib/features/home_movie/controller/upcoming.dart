import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/core/base/index.dart';
import 'package:flutter_getx_the_moviedb/features/home_movie/index.dart';
import 'package:flutter_getx_the_moviedb/models/index.dart';
import 'package:flutter_getx_the_moviedb/ui/widgets/custom_widgets/index.dart';
import 'package:get/get.dart';

class UpcomingMoviesController extends BaseRepositoryController<HomeMovieRepository, HomeMovieProvider, MovieWrapper?> {
  UpcomingMoviesController({
    required this.homeMovieRepository,
  }) : super(repository: homeMovieRepository);

  final HomeMovieRepository homeMovieRepository;
  final ScrollController scrollController = ScrollController();
  final RxBool isLoading = false.obs;

  void pagination() {
    if (scrollController.position.extentAfter < 500 && state != null && state!.totalPages != 0 && state!.totalPages != state!.page && !isLoading.value) {
      _getMovies();
    }
  }

  Future<void> _getMovies() async {
    isLoading.value = true;
    CustomProgressIndicator.openLoadingDialog();

    final MovieWrapper? movieWrapper = await repository.getUpcomingMovie(
      query: <String, dynamic>{
        "page": state!.page! + 1,
      },
    );
    state!.results!.addAll(movieWrapper!.results!);
    state!.page = movieWrapper.page;
    update();

    await CustomProgressIndicator.closeLoadingOverlay();
    isLoading.value = false;
  }

  Future<MovieWrapper?> getInitialMovies() async {
    CustomProgressIndicator.openLoadingDialog();
    final MovieWrapper? movieWrapper = await repository.getUpcomingMovie(
      query: <String, dynamic>{
        "page": 1,
      },
    );
    await CustomProgressIndicator.closeLoadingOverlay();
    return movieWrapper;
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(pagination);
  }

  @override
  void onReady() {
    super.onReady();
    append(() => getInitialMovies);
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.removeListener(pagination);
  }
}
