import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/network/index.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

abstract class IDetailProvider {
  Future<Response<dynamic>> rateMovie(String path, Map<String, dynamic> body);

  Future<Response<dynamic>> rateTvSeries(String path, Map<String, dynamic> body);
}

class DetailProvider extends GetConnect implements IDetailProvider {
  @override
  void onInit() {
    httpClient.baseUrl = Url.movieDbBaseUrl;

    httpClient.addRequestModifier((Request<dynamic> request) {
      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      debugPrint("${request.url.host}/${request.url.path}");
      return request;
    });
  }

  @override
  Future<Response<dynamic>> rateMovie(String path, Map<String, dynamic> body) => post(path, body);

  @override
  Future<Response<dynamic>> rateTvSeries(String path, Map<String, dynamic> body) => post(path, body);
}

abstract class IDetailRepository {
  Future<dynamic> rateMovie(int movieId, Map<String, dynamic> body);

  Future<dynamic> rateTvSeries(int tvSeriesId, Map<String, dynamic> body);
}

class DetailRepository implements IDetailRepository {
  DetailRepository({
    required this.provider,
  });

  final DetailProvider provider;

  @override
  Future<Response<dynamic>> rateMovie(int movieId, Map<String, dynamic> body) async {
    final Response<dynamic> response = await provider.rateMovie(Url.rateMovie(movieId), body);
    debugPrint(response.bodyString.toString());
    if (response.status.hasError) {
      return Future<Response<dynamic>>.error(response);
    } else {
      return response;
    }
  }

  @override
  Future<Response<dynamic>> rateTvSeries(int tvSeriesId, Map<String, dynamic> body) async {
    final Response<dynamic> response = await provider.rateTvSeries(Url.rateTV(tvSeriesId), body);
    debugPrint(response.bodyString.toString());
    if (response.status.hasError) {
      return Future<Response<dynamic>>.error(response);
    } else {
      return response;
    }
  }
}
