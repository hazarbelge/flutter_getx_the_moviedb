import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class ConnectivityUtil {
  static void configureConnectivityStream() {
    Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        switch (result) {
          case ConnectivityResult.wifi:
            try {
              if (Get.context != null) {
                Get.until((Route<dynamic> route) => !(Get.isDialogOpen ?? false));
              }
            } catch (e) {
              debugPrint("GetUntilMethodOnWifiConnectionError: $e");
            }
            debugPrint("ConnectivityResult: Internet Connection With Wifi.");
            break;
          case ConnectivityResult.mobile:
            try {
              if (Get.context != null) {
                Get.until((Route<dynamic> route) => !(Get.isDialogOpen ?? false));
              }
            } catch (e) {
              debugPrint("GetUntilMethodOnMobileConnectionError: $e");
            }
            debugPrint("ConnectivityResult: Internet Connection With Mobile.");
            break;
          case ConnectivityResult.ethernet:
            try {
              if (Get.context != null) {
                Get.until((Route<dynamic> route) => !(Get.isDialogOpen ?? false));
              }
            } catch (e) {
              debugPrint("GetUntilMethodOnEthernetConnectionError: $e");
            }
            debugPrint("ConnectivityResult: Internet Connection With Ethernet.");
            break;
          case ConnectivityResult.bluetooth:
            try {
              if (Get.context != null) {
                Get.until((Route<dynamic> route) => !(Get.isDialogOpen ?? false));
              }
            } catch (e) {
              debugPrint("GetUntilMethodOnBluetoothConnectionError: $e");
            }
            debugPrint("ConnectivityResult: Internet Connection With Bluetooth.");
            break;
          case ConnectivityResult.none:
            debugPrint("ConnectivityResult: No Internet Connection.");
            try {
              if (Get.context != null) {
                Get.dialog(
                  Platform.isIOS || Platform.isMacOS
                      ? WillPopScope(
                          onWillPop: () async => false,
                          child: const CupertinoAlertDialog(
                            title: Text("İnternet Bağlantısı Bulunamadı"),
                            content: Text(
                              "Geçerli bir internet bağlantısı sağlayamadınız sürece bu uygulamayı kullanamazsınız. Lütfen daha sonra tekrar deneyiniz.",
                            ),
                          ),
                        )
                      : WillPopScope(
                          onWillPop: () async => false,
                          child: const AlertDialog(
                            title: Text("İnternet Bağlantısı Bulunamadı"),
                            content: Text(
                              "Geçerli bir internet bağlantısı sağlayamadığınız sürece bu uygulamayı kullanamazsınız. Lütfen daha sonra tekrar deneyiniz.",
                            ),
                          ),
                        ),
                  barrierDismissible: false,
                );
              }
            } catch (e) {
              debugPrint("ShowNoInternetConnectionDialogError: $e");
            }
            break;
        }
      },
    );
  }
}
