import 'package:flutter_getx_the_moviedb/ui/detail/controller/index.dart';
import 'package:flutter_getx_the_moviedb/ui/detail/index.dart';
import 'package:get/get.dart';

class DetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailProvider>(() => DetailProvider());
    Get.lazyPut<DetailRepository>(() => DetailRepository(provider: Get.find()));
    Get.lazyPut(() => DetailPageController());
    Get.lazyPut(() => OverviewController());
    Get.lazyPut(() => RatingRowController(detailRepository: Get.find()));
  }
}
