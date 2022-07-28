import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/network/index.dart';
import "package:get/get_connect/connect.dart";
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get_instance/src/lifecycle.dart';

class BaseProvider extends GetConnect {
  @override
  InternalFinalCallback<void> get onStart {
    debugPrint("BaseProviderOnStart");
    httpClient.baseUrl = Url.movieDbBaseUrl;
    httpClient.addRequestModifier((Request<dynamic> request) {
      debugPrint("${request.url}, Headers - ${request.headers.keys} : ${request.headers.values}");
      return request;
    });
    return super.onStart;
  }

  @override
  Future<Response<T>> get<T>(String url, {Map<String, String>? headers, String? contentType, Map<String, dynamic>? query, Decoder<T>? decoder}) {
    Map<String, dynamic>? queries = query;
    queries ??= <String, dynamic>{};
    queries.addAll(RequestInterceptor.getQueries);
    queries.forEach((String key, dynamic value) {
      queries![key] = value.toString();
    });
    return super.get(
      url,
      headers: RequestInterceptor.getHeaders,
      contentType: contentType,
      query: queries,
      decoder: decoder,
    );
  }

  @override
  Future<Response<T>> post<T>(String? url, dynamic body, {String? contentType, Map<String, String>? headers, Map<String, dynamic>? query, Decoder<T>? decoder, Progress? uploadProgress}) {
    Map<String, dynamic>? queries = query;
    queries ??= <String, dynamic>{};
    queries.addAll(RequestInterceptor.getQueries);
    queries.forEach((String key, dynamic value) {
      queries![key] = value.toString();
    });
    return super.post(
      url,
      body,
      contentType: contentType,
      headers: RequestInterceptor.getHeaders,
      query: queries,
      decoder: decoder,
      uploadProgress: uploadProgress,
    );
  }

  @override
  Future<Response<T>> put<T>(String url, dynamic body, {String? contentType, Map<String, String>? headers, Map<String, dynamic>? query, Decoder<T>? decoder, Progress? uploadProgress}) {
    Map<String, dynamic>? queries = query;
    queries ??= <String, dynamic>{};
    queries.addAll(RequestInterceptor.getQueries);
    queries.forEach((String key, dynamic value) {
      queries![key] = value.toString();
    });
    return super.put(
      url,
      body,
      contentType: contentType,
      headers: RequestInterceptor.getHeaders,
      query: queries,
      decoder: decoder,
      uploadProgress: uploadProgress,
    );
  }

  @override
  Future<Response<T>> delete<T>(String url, {Map<String, String>? headers, String? contentType, Map<String, dynamic>? query, Decoder<T>? decoder}) {
    Map<String, dynamic>? queries = query;
    queries ??= <String, dynamic>{};
    queries.addAll(RequestInterceptor.getQueries);
    queries.forEach((String key, dynamic value) {
      queries![key] = value.toString();
    });
    return super.delete(
      url,
      headers: RequestInterceptor.getHeaders,
      contentType: contentType,
      query: queries,
      decoder: decoder,
    );
  }
}
