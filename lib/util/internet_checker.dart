import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_getx_the_moviedb/routes/index.dart';
import 'package:get/get.dart';
import 'package:flutter_getx_the_moviedb/ui/widgets/index.dart';

class InternetChecker extends StatelessWidget {
  const InternetChecker({
    Key? key,
    required this.child,
    required this.enable,
  }) : super(key: key);

  final Widget child;
  final bool enable;

  Future<void> checkConnectivity() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    switch (result) {
      case ConnectivityResult.wifi:
        debugPrint("İnternet bağlantısı wifi ile gerçekleştiriliyor.");
        break;
      case ConnectivityResult.mobile:
        debugPrint("İnternet bağlantısı mobil veri ile gerçekleştiriliyor.");
        break;
      case ConnectivityResult.none:
        WidgetsBinding.instance!.addPostFrameCallback((Duration duration) {
          Get.dialog(
            Platform.isIOS
                ? const CupertinoAlertDialog(
                    title: Text("İnternet Bağlantısı Bulunamadı"),
                    content: Text(
                      "Geçerli bir internet bağlantısı sağlayamadınız sürece bu uygulamayı kullanamazsınız. Lütfen daha sonra tekrar deneyiniz.",
                    ),
                  )
                : const AlertDialog(
                    title: Text("İnternet Bağlantısı Bulunamadı"),
                    content: Text(
                      "Geçerli bir internet bağlantısı sağlayamadığınız sürece bu uygulamayı kullanamazsınız. Lütfen daha sonra tekrar deneyiniz.",
                    ),
                  ),
            barrierDismissible: false,
          );
          Get.offAndToNamed(AppRoutes.START);
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return enable
        ? StatefulWrapper(
            onInit: () {
              checkConnectivity();
            },
            child: child,
          )
        : child;
  }
}
