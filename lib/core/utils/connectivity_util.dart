import "package:connectivity_plus/connectivity_plus.dart";
import "package:flutter/material.dart";
import 'package:flutter_getx_the_moviedb/ui/widgets/index.dart';
import "package:get/route_manager.dart";

class ConnectivityUtil {
  static void configureConnectivityStream() {
    bool noConnection = false;
    Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        switch (result) {
          case ConnectivityResult.wifi:
            if (noConnection) {
              try {
                Navigator.pop(Get.overlayContext!);
                noConnection = false;
              } catch (e) {
                debugPrint("GetUntilMethodOnWifiConnectionError: $e");
              }
            }
            debugPrint("ConnectivityResult: Internet Connection With Wifi.");
            break;
          case ConnectivityResult.mobile:
            if (noConnection) {
              try {
                Navigator.pop(Get.overlayContext!);
                noConnection = false;
              } catch (e) {
                debugPrint("GetUntilMethodOnMobileConnectionError: $e");
              }
            }
            debugPrint("ConnectivityResult: Internet Connection With Mobile.");
            break;
          case ConnectivityResult.ethernet:
            if (noConnection) {
              try {
                Navigator.pop(Get.overlayContext!);
                noConnection = false;
              } catch (e) {
                debugPrint("GetUntilMethodOnEthernetConnectionError: $e");
              }
            }
            debugPrint("ConnectivityResult: Internet Connection With Ethernet.");
            break;
          case ConnectivityResult.bluetooth:
            if (noConnection) {
              try {
                Navigator.pop(Get.overlayContext!);
                noConnection = false;
              } catch (e) {
                debugPrint("GetUntilMethodOnBluetoothConnectionError: $e");
              }
            }
            debugPrint("ConnectivityResult: Internet Connection With Bluetooth.");
            break;
          case ConnectivityResult.vpn:
            if (noConnection) {
              try {
                Navigator.pop(Get.overlayContext!);
                noConnection = false;
              } catch (e) {
                debugPrint("GetUntilMethodOnVpnConnectionError: $e");
              }
            }
            debugPrint("ConnectivityResult: Internet Connection With VPN.");
            break;
          case ConnectivityResult.other:
            if (noConnection) {
              try {
                Navigator.pop(Get.overlayContext!);
                noConnection = false;
              } catch (e) {
                debugPrint("GetUntilMethodOnOtherConnectionError: $e");
              }
            }
            debugPrint("ConnectivityResult: Internet Connection With Other.");
            break;
          case ConnectivityResult.none:
            debugPrint("ConnectivityResult: No Internet Connection.");
            try {
              if (Get.overlayContext != null && !noConnection) {
                noConnection = true;
                showDialog(
                  context: Get.overlayContext!,
                  builder: (BuildContext ctx) {
                    return const NoConnectionWidget();
                  },
                  barrierDismissible: false,
                  useSafeArea: false,
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
