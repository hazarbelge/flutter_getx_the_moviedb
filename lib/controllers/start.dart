import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/models/index.dart';
import 'package:flutter_getx_the_moviedb/providers/index.dart';
import 'package:get/get.dart';

class StartScreenController extends SuperController<SessionData?> {
  StartScreenController({
    required this.startRepository,
  });

  final IStartRepository startRepository;

  @override
  void onInit() {
    super.onInit();

    append(() => startRepository.getSessionId);
  }

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
