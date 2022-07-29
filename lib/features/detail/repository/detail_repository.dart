import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/core/base/index.dart';
import 'package:flutter_getx_the_moviedb/network/index.dart';
import 'package:get/get.dart';

abstract class IDetailProvider {
  Future<Response<dynamic>> rateMovie(String path, Map<String, dynamic> body);

  Future<Response<dynamic>> rateTvSeries(String path, Map<String, dynamic> body);
}

class DetailProvider extends BaseProvider implements IDetailProvider {
  @override
  Future<Response<dynamic>> rateMovie(String path, Map<String, dynamic> body) => post(path, body);

  @override
  Future<Response<dynamic>> rateTvSeries(String path, Map<String, dynamic> body) => post(path, body);
}

abstract class IDetailRepository {
  Future<dynamic> rateMovie(int movieId, Map<String, dynamic> body);

  Future<dynamic> rateTvSeries(int tvSeriesId, Map<String, dynamic> body);
}

class DetailRepository extends BaseRepository<DetailProvider> implements IDetailRepository {
  DetailRepository() : super(provider: DetailProvider());

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
