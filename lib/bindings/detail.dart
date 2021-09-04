import 'package:get/get.dart';

import '../../controllers/index.dart';

class DetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailPageController());
  }
}
