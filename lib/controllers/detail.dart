import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/index.dart';

class DetailPageController extends SuperController<Map<String, dynamic>> {
  DetailPageController();

  Movie? movie;
  TvSeries? tvSeries;
  bool? isMovie;

  @override
  void onInit() {
    super.onInit();

    debugPrint("${Get.arguments}");
    debugPrint("${Get.parameters}");
    change(Get.arguments, status: RxStatus.success());

    movie = state?['movie'];
    tvSeries = state?['tvSeries'];
    isMovie = state?['isMovie'];
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
