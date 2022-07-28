import "package:flutter/material.dart";
import 'package:flutter_getx_the_moviedb/core/base/index.dart';
import "package:get/get.dart";

class BaseRepositoryController<R extends BaseRepository<P>, P extends BaseProvider, T extends Object?> extends SuperController<T> {
  BaseRepositoryController({
    required this.repository,
  });

  final R repository;

  @override
  void onInit() {
    super.onInit();
    debugPrint("$runtimeType onInit called");
  }

  @override
  void onReady() {
    super.onReady();
    debugPrint("$runtimeType onReady called");
  }

  @override
  void onClose() {
    super.onClose();
    debugPrint("$runtimeType onClose called");
  }

  @override
  void onDetached() {
    debugPrint("$runtimeType onDetached called");
  }

  @override
  void onInactive() {
    debugPrint("$runtimeType onInactive called");
  }

  @override
  void onPaused() {
    debugPrint("$runtimeType onPaused called");
  }

  @override
  void onResumed() {
    debugPrint("$runtimeType onResumed called");
  }
}

class BaseController<T extends Object?> extends SuperController<T> {
  BaseController();

  @override
  void onInit() {
    super.onInit();
    debugPrint("$runtimeType onInit called");
  }

  @override
  void onReady() {
    super.onReady();
    debugPrint("$runtimeType onReady called");
  }

  @override
  void onClose() {
    super.onClose();
    debugPrint("$runtimeType onClose called");
  }

  @override
  void onDetached() {
    debugPrint("$runtimeType onDetached called");
  }

  @override
  void onInactive() {
    debugPrint("$runtimeType onInactive called");
  }

  @override
  void onPaused() {
    debugPrint("$runtimeType onPaused called");
  }

  @override
  void onResumed() {
    debugPrint("$runtimeType onResumed called");
  }
}
