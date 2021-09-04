import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/index.dart';
import '../../providers/index.dart';

class NowPlayingMoviesController extends SuperController<MovieWrapper?> {
  NowPlayingMoviesController({
    required this.homeMovieRepository,
  });

  final IHomeMovieRepository homeMovieRepository;

  @override
  void onInit() {
    super.onInit();

    append(() => homeMovieRepository.getNowPlayingMovie);
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
