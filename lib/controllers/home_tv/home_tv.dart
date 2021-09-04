import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeTvScreenController extends SuperController<dynamic> {
  HomeTvScreenController();

  final RxInt currentIndex = 0.obs;

  @override
  void onDetached() {
    debugPrint('onDetached called');
  }

  @override
  void onInactive() {
    debugPrint('onInative called');
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
