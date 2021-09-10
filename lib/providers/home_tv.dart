import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

import '../../models/index.dart';
import '../../util/index.dart';

abstract class IHomeTvProvider {
  Future<Response<TvSeriesWrapper>> getAiringTodayTvSeries({required String path, Map<String, dynamic>? query});

  Future<Response<TvSeriesWrapper>> getOnTheAirTvSeries({required String path, Map<String, dynamic>? query});

  Future<Response<TvSeriesWrapper>> getPopularTvSeries({required String path, Map<String, dynamic>? query});

  Future<Response<TvSeriesWrapper>> getTopRatedTvSeries({required String path, Map<String, dynamic>? query});
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
  Future<Response<T>> get<T>(String url, {Map<String, String>? headers, String? contentType, Map<String, dynamic>? query, Decoder<T>? decoder}) {
    Map<String, dynamic>? parsedQuery = query?.map((String key, dynamic value) => MapEntry<String, dynamic>(key, value.toString()));
    if (parsedQuery == null) {
      parsedQuery = <String, dynamic>{
        "api_key": Url.apiKey,
      };
    } else {
      parsedQuery.addAll(
        <String, dynamic>{
          "api_key": Url.apiKey,
        },
      );
    }
    return super.get(url, headers: headers, contentType: contentType, query: parsedQuery, decoder: decoder);
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

class HomeTvRepository implements IHomeTvRepository {
  HomeTvRepository({
    required this.provider,
  });

  final HomeTvProvider provider;

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
