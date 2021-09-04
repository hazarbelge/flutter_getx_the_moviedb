import 'package:get/get.dart';

import '../../controllers/index.dart';
import '../../providers/index.dart';

class StartBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IStartProvider>(() => StartProvider());
    Get.lazyPut<IStartRepository>(() => StartRepository(provider: Get.find()));
    Get.lazyPut(() => StartScreenController(startRepository: Get.find()));
  }
}
