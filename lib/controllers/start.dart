import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/index.dart';
import '../../providers/index.dart';

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
