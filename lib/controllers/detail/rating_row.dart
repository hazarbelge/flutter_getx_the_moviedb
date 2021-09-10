import 'package:get/get.dart';

import '../../providers/index.dart';

class RatingRowController extends GetxController {
  RatingRowController({
    required this.detailRepository,
  });

  final DetailRepository detailRepository;

  final RxBool isRated = false.obs;
  final RxBool isRatedApi = false.obs;
  final RxDouble rate = 0.0.obs;
}
