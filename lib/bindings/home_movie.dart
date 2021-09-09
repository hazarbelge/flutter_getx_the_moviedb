import 'package:get/get.dart';

import '../../controllers/index.dart';
import '../../providers/index.dart';

class HomeMovieBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeMovieProvider>(() => HomeMovieProvider());
    Get.lazyPut<HomeMovieRepository>(() => HomeMovieRepository(provider: Get.find()));
    Get.lazyPut(() => HomeMovieScreenController());
    Get.lazyPut(() => NowPlayingMoviesController(homeMovieRepository: Get.find()));
    Get.lazyPut(() => PopularMoviesController(homeMovieRepository: Get.find()));
    Get.lazyPut(() => TopRatedMoviesController(homeMovieRepository: Get.find()));
    Get.lazyPut(() => UpcomingMoviesController(homeMovieRepository: Get.find()));
  }
}
