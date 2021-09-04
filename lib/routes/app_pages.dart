import 'package:get/get.dart';

import '../../bindings/index.dart';
import '../../routes/index.dart';
import '../../ui/screens/index.dart';

class AppPages {
  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage<dynamic>(
      name: AppRoutes.START,
      page: () => const StartScreen(),
      binding: StartBinding(),
      preventDuplicates: true,
      children: <GetPage<dynamic>>[
        GetPage<dynamic>(
          name: AppRoutes.HOME_MOVIE,
          page: () => const HomeMovieScreen(),
          transition: Transition.cupertino,
          binding: HomeMovieBinding(),
          children: <GetPage<dynamic>>[
            GetPage<dynamic>(
              name: AppRoutes.DETAIL_MOVIE,
              page: () => const DetailPage(),
              transition: Transition.cupertino,
              binding: DetailPageBinding(),
            ),
          ],
        ),
        GetPage<dynamic>(
          name: AppRoutes.HOME_TV,
          page: () => const HomeTvScreen(),
          transition: Transition.cupertino,
          binding: HomeTvBinding(),
          children: <GetPage<dynamic>>[
            GetPage<dynamic>(
              name: AppRoutes.DETAIL_TV,
              page: () => const DetailPage(),
              transition: Transition.cupertino,
              binding: DetailPageBinding(),
            ),
          ],
        ),
      ],
    ),
  ];
}
