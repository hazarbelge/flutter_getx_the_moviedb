import 'package:get/get.dart';

import '../../controllers/index.dart';
import '../../providers/index.dart';

class DetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IDetailProvider>(() => DetailProvider());
    Get.lazyPut<IDetailRepository>(() => DetailRepository(provider: Get.find()));
    Get.lazyPut(() => DetailPageController());
    Get.lazyPut(() => OverviewController());
    Get.lazyPut(() => RatingRowController(detailRepository: Get.find()));
  }
}
