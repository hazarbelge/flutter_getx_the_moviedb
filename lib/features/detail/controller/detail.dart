import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/core/base/index.dart';
import 'package:flutter_getx_the_moviedb/models/index.dart';
import 'package:get/get.dart';

class DetailPageController extends BaseController<Map<String, dynamic>> {
  DetailPageController();

  final RxInt currentIndex = 0.obs;

  Movie? movie;
  TvSeries? tvSeries;
  bool? isMovie;

  @override
  void onInit() {
    super.onInit();
    debugPrint("${Get.arguments}");
    change(Get.arguments, status: RxStatus.success());

    movie = state?['movie'];
    tvSeries = state?['tvSeries'];
    isMovie = state?['isMovie'];
  }
}
