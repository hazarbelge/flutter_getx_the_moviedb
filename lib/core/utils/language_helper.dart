import "package:flutter/material.dart";
import 'package:flutter_getx_the_moviedb/core/utils/index.dart';
import "package:get/get.dart";

class LanguageHelper {
  static void languageSave() {
    StorageUtil.write("language_code", Get.locale?.languageCode);
    StorageUtil.write("country_code", Get.locale?.countryCode);
    debugPrint("Locale ${Get.locale?.languageCode}_${Get.locale?.countryCode} is saved.");
  }

  static String? getLanguageCode() {
    return StorageUtil.read<String>("language_code");
  }

  static String? getCountryCode() {
    return StorageUtil.read<String>("country_code");
  }

  static Locale? getLocale() {
    final String? languageCode = StorageUtil.read<String>("language_code");
    final String? countryCode = StorageUtil.read<String>("country_code");
    return languageCode != null && countryCode != null ? Locale(languageCode, countryCode) : Get.locale;
  }
}
