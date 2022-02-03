import 'package:flutter_getx_the_moviedb/ui/detail/index.dart';
import 'package:get/get.dart';

class RatingRowController extends GetxController {
  RatingRowController({
    required this.detailRepository,
  });

  final DetailRepository detailRepository;

  final RxBool isRated = false.obs;
  final RxBool isRatedApi = false.obs;
  final RxDouble rate = 0.0.obs;
}
