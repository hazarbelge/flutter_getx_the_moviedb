import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/core/utils/index.dart';
import 'package:flutter_getx_the_moviedb/network/index.dart';

class RequestInterceptor {
  static Map<String, String> get getHeaders {
    final Map<String, String> headers = <String, String>{
      "Content-Type": "application/json",
      "Accept-Type": "application/json",
      if (LanguageHelper.getLocale() != null) "Accept-Language": LanguageHelper.getLocale().toString(),
    };
    debugPrint("Headers - ${headers.keys} : ${headers.values}");
    return headers;
  }

  static Map<String, dynamic> get getQueries {
    final Map<String, dynamic> queries = <String, dynamic>{
      "api_key": Url.apiKey,
      if (LanguageHelper.getLanguageCode() != null && LanguageHelper.getCountryCode() != null) "language": "${LanguageHelper.getLanguageCode()}-${LanguageHelper.getCountryCode()}",
      if (Url.guestSessionId != null) "guest_session_id": Url.guestSessionId,
    };
    debugPrint("Queries - ${queries.keys} : ${queries.values}");
    return queries;
  }
}
