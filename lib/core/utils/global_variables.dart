import "package:dio/dio.dart";

class GlobalVariables {
  static _App app = _App();
  static _Images images = _Images();
}

class _App {
  late Dio client;
  bool restartRequired = false;
}

class _Images {
  String get appIconPath => "assets/icons/app_icon.svg";

  String get appIconPngPath => "assets/icons/app_icon.png";

  String get appLogoPath => "assets/icons/app_logo.png";
}
