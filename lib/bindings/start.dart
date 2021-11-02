import 'package:flutter_getx_the_moviedb/controllers/index.dart';
import 'package:flutter_getx_the_moviedb/providers/index.dart';
import 'package:get/get.dart';

class StartBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IStartProvider>(() => StartProvider());
    Get.lazyPut<IStartRepository>(() => StartRepository(provider: Get.find()));
    Get.lazyPut(() => StartScreenController(startRepository: Get.find()));
  }
}
