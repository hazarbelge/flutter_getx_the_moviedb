import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/index.dart';
import '../../providers/index.dart';

class PopularTvSeriesController extends SuperController<TvSeriesWrapper?> {
  PopularTvSeriesController({
    required this.homeTvRepository,
  });

  final IHomeTvRepository homeTvRepository;

  @override
  void onInit() {
    super.onInit();

    append(() => homeTvRepository.getPopularTvSeries);
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