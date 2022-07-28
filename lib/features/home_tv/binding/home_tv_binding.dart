import 'package:flutter_getx_the_moviedb/features/home_tv/index.dart';
import 'package:get/get.dart';

class HomeTvBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeTvProvider>(() => HomeTvProvider());
    Get.lazyPut<HomeTvRepository>(() => HomeTvRepository());
    Get.lazyPut(() => HomeTvScreenController());
    Get.lazyPut(() => AiringTodayTvSeriesController(homeTvRepository: Get.find()));
    Get.lazyPut(() => OnTheAirTvSeriesController(homeTvRepository: Get.find()));
    Get.lazyPut(() => PopularTvSeriesController(homeTvRepository: Get.find()));
    Get.lazyPut(() => TopRatedTvSeriesController(homeTvRepository: Get.find()));
  }
}
