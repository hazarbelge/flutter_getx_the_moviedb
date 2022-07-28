import "package:flutter/material.dart";
import "package:get/get.dart";

class NoConnectionWidget extends StatelessWidget {
  const NoConnectionWidget({
    Key? key,
    this.restartRequired = false,
  }) : super(key: key);

  final bool restartRequired;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(color: Get.theme.primaryColor),
            const SizedBox(height: 20),
            Text(
              restartRequired ? "app.restart.required".tr : "app.no.internet".tr,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
