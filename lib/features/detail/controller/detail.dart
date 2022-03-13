import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/models/index.dart';
import 'package:get/get.dart';

class DetailPageController extends SuperController<Map<String, dynamic>> {
  DetailPageController();

  final RxInt currentIndex = 0.obs;

  Movie? movie;
  TvSeries? tvSeries;
  bool? isMovie;

  @override
  void onInit() {
    super.onInit();
    debugPrint('$runtimeType onInit called');

    debugPrint("${Get.arguments}");
    change(Get.arguments, status: RxStatus.success());

    movie = state?['movie'];
    tvSeries = state?['tvSeries'];
    isMovie = state?['isMovie'];
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
