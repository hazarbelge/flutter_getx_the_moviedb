import 'package:get/get.dart';

class OverviewController extends GetxController {
  OverviewController();

  final RxBool flag = true.obs;
  final RxString visibleText = ''.obs;
  final RxString invisibleText = ''.obs;
}
