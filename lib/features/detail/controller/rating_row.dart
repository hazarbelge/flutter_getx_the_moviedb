import 'package:flutter_getx_the_moviedb/core/base/index.dart';
import 'package:flutter_getx_the_moviedb/features/detail/index.dart';
import 'package:get/get.dart';

class RatingRowController extends BaseRepositoryController<DetailRepository, DetailProvider, dynamic> {
  RatingRowController({
    required this.detailRepository,
  }) : super(repository: detailRepository);

  final DetailRepository detailRepository;

  final RxBool isRated = false.obs;
  final RxBool isRatedApi = false.obs;
  final RxDouble rate = 0.0.obs;
}
