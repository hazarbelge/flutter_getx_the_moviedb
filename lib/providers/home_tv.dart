import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

import '../../models/index.dart';
import '../../util/index.dart';

abstract class IHomeTvProvider {
  Future<Response<TvSeriesWrapper>> getAiringTodayTvSeries(String path);

  Future<Response<TvSeriesWrapper>> getOnTheAirTvSeries(String path);

  Future<Response<TvSeriesWrapper>> getPopularTvSeries(String path);

  Future<Response<TvSeriesWrapper>> getTopRatedTvSeries(String path);
}

class HomeTvProvider extends GetConnect implements IHomeTvProvider {
  @override
  void onInit() {
    httpClient.defaultDecoder = (dynamic val) => TvSeriesWrapper.fromJson(val as Map<String, dynamic>);
    httpClient.baseUrl = Url.movieDbBaseUrl;

    httpClient.addRequestModifier((Request<dynamic> request) {
      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      debugPrint("${request.url.path}/${request.url.host}");
      return request;
    });
  }

  @override
  Future<Response<TvSeriesWrapper>> getAiringTodayTvSeries(String path) => get(path);

  @override
  Future<Response<TvSeriesWrapper>> getOnTheAirTvSeries(String path) => get(path);

  @override
  Future<Response<TvSeriesWrapper>> getPopularTvSeries(String path) => get(path);

  @override
  Future<Response<TvSeriesWrapper>> getTopRatedTvSeries(String path) => get(path);
}

abstract class IHomeTvRepository {
  Future<TvSeriesWrapper?> getAiringTodayTvSeries();

  Future<TvSeriesWrapper?> getOnTheAirTvSeries();

  Future<TvSeriesWrapper?> getPopularTvSeries();

  Future<TvSeriesWrapper?> getTopRatedTvSeries();
}

class HomeTvRepository implements IHomeTvRepository {
  HomeTvRepository({
    required this.provider,
  });

  final HomeTvProvider provider;

  @override
  Future<TvSeriesWrapper?> getAiringTodayTvSeries() async {
    final Response<TvSeriesWrapper> response = await provider.getAiringTodayTvSeries(Url.airingTodayTv);
    debugPrint(response.bodyString.toString());
    if (response.status.hasError) {
      return Future<TvSeriesWrapper>.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  @override
  Future<TvSeriesWrapper?> getOnTheAirTvSeries() async {
    final Response<TvSeriesWrapper> response = await provider.getOnTheAirTvSeries(Url.onTheAirTv);
    debugPrint(response.bodyString.toString());
    if (response.status.hasError) {
      return Future<TvSeriesWrapper>.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  @override
  Future<TvSeriesWrapper?> getPopularTvSeries() async {
    final Response<TvSeriesWrapper> response = await provider.getPopularTvSeries(Url.popularTv);
    debugPrint(response.bodyString.toString());
    if (response.status.hasError) {
      return Future<TvSeriesWrapper>.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  @override
  Future<TvSeriesWrapper?> getTopRatedTvSeries() async {
    final Response<TvSeriesWrapper> response = await provider.getTopRatedTvSeries(Url.topRatedTv);
    debugPrint(response.bodyString.toString());
    if (response.status.hasError) {
      return Future<TvSeriesWrapper>.error(response.statusText!);
    } else {
      return response.body;
    }
  }
}
