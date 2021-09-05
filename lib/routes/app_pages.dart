import 'package:get/get.dart';

import '../../bindings/index.dart';
import '../../routes/index.dart';
import '../../ui/screens/index.dart';

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
    ),
    GetPage<HomeTvScreen>(
      name: AppRoutes.HOME_TV,
      page: () => const HomeTvScreen(),
      transition: Transition.fadeIn,
      binding: HomeTvBinding(),
    ),
    GetPage<DetailPage>(
      name: AppRoutes.DETAIL,
      page: () => const DetailPage(),
      transition: Transition.fadeIn,
      binding: DetailPageBinding(),
    ),
  ];
}
