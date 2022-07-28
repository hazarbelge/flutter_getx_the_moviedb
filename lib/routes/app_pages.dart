import 'package:flutter_getx_the_moviedb/features/detail/index.dart';
import 'package:flutter_getx_the_moviedb/features/home_movie/index.dart';
import 'package:flutter_getx_the_moviedb/features/home_tv/index.dart';
import 'package:flutter_getx_the_moviedb/features/splash/index.dart';
import 'package:flutter_getx_the_moviedb/routes/index.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage<SplashScreen>(
      name: AppRoutes.START,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
      preventDuplicates: true,
    ),
    GetPage<HomeMovieScreen>(
      name: AppRoutes.HOME_MOVIE,
      page: () => const HomeMovieScreen(),
      transition: Transition.fadeIn,
      binding: HomeMovieBinding(),
      preventDuplicates: true,
    ),
    GetPage<HomeTvScreen>(
      name: AppRoutes.HOME_TV,
      page: () => const HomeTvScreen(),
      transition: Transition.fadeIn,
      binding: HomeTvBinding(),
      preventDuplicates: true,
    ),
    GetPage<DetailScreen>(
      name: AppRoutes.DETAIL,
      page: () => const DetailScreen(),
      transition: Transition.fadeIn,
      binding: DetailPageBinding(),
      preventDuplicates: true,
    ),
  ];
}
