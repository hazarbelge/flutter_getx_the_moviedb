import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/features/detail/index.dart';
import 'package:get/get.dart';

class Overview extends GetView<OverviewController> {
  const Overview({
    Key? key,
    required this.overview,
    this.subLength = 200,
  }) : super(key: key);

  final String overview;
  final int subLength;

  @override
  Widget build(BuildContext context) {
    if (overview.length > subLength) {
      controller.visibleText.value = overview.substring(0, subLength);
      controller.invisibleText.value = overview.substring(subLength, overview.length);
      controller.flag.value = true;
    } else {
      controller.visibleText.value = overview;
      controller.invisibleText.value = "";
      controller.flag.value = false;
    }
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Obx(
            () => Text(
              controller.flag.value ? "${controller.visibleText.value}..." : controller.visibleText.value + controller.invisibleText.value,
              style: textTheme.bodyText2!.copyWith(
                color: Get.isDarkMode ? Colors.white : Colors.black45,
                fontSize: 16.0,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.flag.value = !controller.flag.value;
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  controller.flag.value ? 'details.more'.tr : 'details.less'.tr,
                  style: textTheme.bodyText2!.copyWith(fontSize: 16.0, color: Get.isDarkMode ? Colors.orange : Colors.blue),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 18.0,
                  color: Get.isDarkMode ? Colors.orange : Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
