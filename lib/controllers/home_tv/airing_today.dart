import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/index.dart';
import '../../providers/index.dart';

class AiringTodayTvSeriesController extends SuperController<TvSeriesWrapper?> {
  AiringTodayTvSeriesController({
    required this.homeTvRepository,
  });

  final IHomeTvRepository homeTvRepository;

  @override
  void onInit() {
    super.onInit();

    append(() => homeTvRepository.getAiringTodayTvSeries);
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
