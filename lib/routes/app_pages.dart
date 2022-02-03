import 'package:flutter_getx_the_moviedb/routes/index.dart';
import 'package:flutter_getx_the_moviedb/ui/detail/index.dart';
import 'package:flutter_getx_the_moviedb/ui/home_movie/index.dart';
import 'package:flutter_getx_the_moviedb/ui/home_tv/index.dart';
import 'package:flutter_getx_the_moviedb/ui/start/index.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage<StartScreen>(
      name: AppRoutes.START,
      page: () => const StartScreen(),
      binding: StartBinding(),
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
