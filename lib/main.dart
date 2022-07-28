import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/app.dart';
import 'package:flutter_getx_the_moviedb/core/utils/index.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> initServices() async {
  ConnectivityUtil.configureConnectivityStream();
  GlobalVariables.app.client = Dio(
    BaseOptions(
      headers: <String, String>{
        "Content-Type": "application/json;charset=utf-8",
        "Accept": "application/json;charset=utf-8",
      },
    ),
  );

  debugPrint('Starting GetX Services...');
  await Future.wait(
    <Future<dynamic>>[
      StorageUtil.init(),
      Get.putAsync(() => GlobalVariablesService().init()),
    ],
  );
  debugPrint('All GetX Services Started...');
}

Future<void> main() async {
  debugPrint = (String? message, {int? wrapWidth}) {
    if (!kReleaseMode) {
      log(message.toString());
    }
  };

  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded<Future<void>>(
    () async {
      await initServices();
      setPathUrlStrategy();
      runApp(
        const MovieApp(),
      );
    },
    (Object error, StackTrace stack) {
      debugPrint('ErrorAboutMovieApp: $error, $stack');
    },
  );
}
