import "package:dio/dio.dart";

class GlobalVariables {
  static _App app = _App();
  static _Images images = _Images();
}

class _App {
  _App();

  late Dio client;
  bool restartRequired = false;
}

class _Images {
  _Images();

  String get appIconPath => "assets/launcher/app_icon.svg";
  String get appIconPngPath => "assets/launcher/app_icon.png";
  String get appLogoPath => "assets/launcher/app_logo.png";
}
