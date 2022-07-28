import 'package:flutter_getx_the_moviedb/core/base/index.dart';
import 'package:get/get.dart';

class OverviewController extends BaseController<dynamic> {
  OverviewController();

  final RxBool flag = true.obs;
  final RxString visibleText = ''.obs;
  final RxString invisibleText = ''.obs;
}
