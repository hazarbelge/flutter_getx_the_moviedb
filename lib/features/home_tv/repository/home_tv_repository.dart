import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/core/base/index.dart';
import 'package:flutter_getx_the_moviedb/models/index.dart';
import 'package:flutter_getx_the_moviedb/network/index.dart';
import 'package:get/get.dart';

abstract class IHomeTvProvider {
  Future<Response<TvSeriesWrapper>> getAiringTodayTvSeries({required String path, Map<String, dynamic>? query});

  Future<Response<TvSeriesWrapper>> getOnTheAirTvSeries({required String path, Map<String, dynamic>? query});

  Future<Response<TvSeriesWrapper>> getPopularTvSeries({required String path, Map<String, dynamic>? query});

  Future<Response<TvSeriesWrapper>> getTopRatedTvSeries({required String path, Map<String, dynamic>? query});
}

class HomeTvProvider extends BaseProvider implements IHomeTvProvider {
  @override
  InternalFinalCallback<void> get onStart {
    httpClient.defaultDecoder = (dynamic val) => TvSeriesWrapper.fromJson(val as Map<String, dynamic>);
    return super.onStart;
  }

  @override
  Future<Response<TvSeriesWrapper>> getAiringTodayTvSeries({required String path, Map<String, dynamic>? query}) => get(path, query: query);

  @override
  Future<Response<TvSeriesWrapper>> getOnTheAirTvSeries({required String path, Map<String, dynamic>? query}) => get(path, query: query);

  @override
  Future<Response<TvSeriesWrapper>> getPopularTvSeries({required String path, Map<String, dynamic>? query}) => get(path, query: query);

  @override
  Future<Response<TvSeriesWrapper>> getTopRatedTvSeries({required String path, Map<String, dynamic>? query}) => get(path, query: query);
}

abstract class IHomeTvRepository {
  Future<TvSeriesWrapper?> getAiringTodayTvSeries({Map<String, dynamic>? query});

  Future<TvSeriesWrapper?> getOnTheAirTvSeries({Map<String, dynamic>? query});

  Future<TvSeriesWrapper?> getPopularTvSeries({Map<String, dynamic>? query});

  Future<TvSeriesWrapper?> getTopRatedTvSeries({Map<String, dynamic>? query});
}

class HomeTvRepository extends BaseRepository<HomeTvProvider> implements IHomeTvRepository {
  HomeTvRepository() : super(provider: HomeTvProvider());

  @override
  Future<TvSeriesWrapper?> getAiringTodayTvSeries({Map<String, dynamic>? query}) async {
    final Response<TvSeriesWrapper> response = await provider.getAiringTodayTvSeries(path: Url.airingTodayTv, query: query);
    debugPrint(response.bodyString.toString());
    if (response.status.hasError) {
      return Future<TvSeriesWrapper>.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  @override
  Future<TvSeriesWrapper?> getOnTheAirTvSeries({Map<String, dynamic>? query}) async {
    final Response<TvSeriesWrapper> response = await provider.getOnTheAirTvSeries(path: Url.onTheAirTv, query: query);
    debugPrint(response.bodyString.toString());
    if (response.status.hasError) {
      return Future<TvSeriesWrapper>.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  @override
  Future<TvSeriesWrapper?> getPopularTvSeries({Map<String, dynamic>? query}) async {
    final Response<TvSeriesWrapper> response = await provider.getPopularTvSeries(path: Url.popularTv, query: query);
    debugPrint(response.bodyString.toString());
    if (response.status.hasError) {
      return Future<TvSeriesWrapper>.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  @override
  Future<TvSeriesWrapper?> getTopRatedTvSeries({Map<String, dynamic>? query}) async {
    final Response<TvSeriesWrapper> response = await provider.getTopRatedTvSeries(path: Url.topRatedTv, query: query);
    debugPrint(response.bodyString.toString());
    if (response.status.hasError) {
      return Future<TvSeriesWrapper>.error(response.statusText!);
    } else {
      return response.body;
    }
  }
}
