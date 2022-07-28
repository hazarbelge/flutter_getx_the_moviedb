import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_getx_the_moviedb/core/base/index.dart';
import 'package:flutter_getx_the_moviedb/core/utils/index.dart';
import 'package:flutter_getx_the_moviedb/features/splash/index.dart';
import 'package:flutter_getx_the_moviedb/models/index.dart';
import 'package:flutter_getx_the_moviedb/ui/widgets/index.dart';
import 'package:get/get.dart';

class SplashScreenController extends BaseRepositoryController<SplashRepository, SplashProvider, SessionData?> {
  SplashScreenController() : super(repository: SplashRepository());

  Future<bool> _connectivityCheck() async {
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      return true;
    } else {
      await Get.to(
        () => const NoConnectionWidget(
          restartRequired: true,
        ),
      );
      return false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    append(() => repository.getSessionId);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    if (LanguageHelper.getLocale() == null && Get.locale == null) {
      await Get.updateLocale(TranslationsUtil.fallbackLocale);
    }
    LanguageHelper.languageSave();

    final bool isConnected = await _connectivityCheck();

    if (GlobalVariables.app.restartRequired || !isConnected) {
      await Get.to(
        () => const NoConnectionWidget(
          restartRequired: true,
        ),
      );
    }
  }
}
