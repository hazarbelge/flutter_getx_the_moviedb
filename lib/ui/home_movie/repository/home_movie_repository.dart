import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/models/index.dart';
import 'package:flutter_getx_the_moviedb/utils/index.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

abstract class IHomeMovieProvider {
  Future<Response<MovieWrapper>> getNowPlayingMovie({required String path, Map<String, dynamic>? query});

  Future<Response<MovieWrapper>> getPopularMovie({required String path, Map<String, dynamic>? query});

  Future<Response<MovieWrapper>> getTopRatedMovie({required String path, Map<String, dynamic>? query});

  Future<Response<MovieWrapper>> getUpcomingMovie({required String path, Map<String, dynamic>? query});
}

class HomeMovieProvider extends GetConnect implements IHomeMovieProvider {
  @override
  void onInit() {
    httpClient.defaultDecoder = (dynamic val) => MovieWrapper.fromJson(val as Map<String, dynamic>);
    httpClient.baseUrl = Url.movieDbBaseUrl;

    httpClient.addRequestModifier((Request<dynamic> request) {
      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      debugPrint("${request.url.host}/${request.url.path}/${request.url.query}");
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
  Future<Response<MovieWrapper>> getNowPlayingMovie({required String path, Map<String, dynamic>? query}) => get(path, query: query);

  @override
  Future<Response<MovieWrapper>> getPopularMovie({required String path, Map<String, dynamic>? query}) => get(path, query: query);

  @override
  Future<Response<MovieWrapper>> getTopRatedMovie({required String path, Map<String, dynamic>? query}) => get(path, query: query);

  @override
  Future<Response<MovieWrapper>> getUpcomingMovie({required String path, Map<String, dynamic>? query}) => get(path, query: query);
}

abstract class IHomeMovieRepository {
  Future<MovieWrapper?> getNowPlayingMovie({Map<String, dynamic>? query});

  Future<MovieWrapper?> getPopularMovie({Map<String, dynamic>? query});

  Future<MovieWrapper?> getTopRatedMovie({Map<String, dynamic>? query});

  Future<MovieWrapper?> getUpcomingMovie({Map<String, dynamic>? query});
}

class HomeMovieRepository implements IHomeMovieRepository {
  HomeMovieRepository({
    required this.provider,
  });

  final HomeMovieProvider provider;

  @override
  Future<MovieWrapper?> getNowPlayingMovie({Map<String, dynamic>? query}) async {
    try {
      final Response<MovieWrapper> response = await provider.getNowPlayingMovie(path: Url.nowPlayingMovies, query: query);
      debugPrint(response.bodyString.toString());
      if (response.status.hasError) {
        debugPrint("NowPlayingMovieError: ${response.statusText}");
        return response.body; //Future<MovieWrapper>.error(response.statusText!);
      } else {
        return response.body;
      }
    } catch (e) {
      debugPrint("NowPlayingMovieCatchError: $e");
      return MovieWrapper(page: 0, totalResults: 0, totalPages: 0, results: <Movie>[]);
    }
  }

  @override
  Future<MovieWrapper?> getPopularMovie({Map<String, dynamic>? query}) async {
    final Response<MovieWrapper> response = await provider.getPopularMovie(path: Url.popularMovies, query: query);
    debugPrint(response.bodyString.toString());
    if (response.status.hasError) {
      debugPrint("PopularMovieError: ${response.statusText}");
      return Future<MovieWrapper>.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  @override
  Future<MovieWrapper?> getTopRatedMovie({Map<String, dynamic>? query}) async {
    final Response<MovieWrapper> response = await provider.getTopRatedMovie(path: Url.topRatedMovies, query: query);
    debugPrint(response.bodyString.toString());
    if (response.status.hasError) {
      debugPrint("TopRatedMovieError: ${response.statusText}");
      return Future<MovieWrapper>.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  @override
  Future<MovieWrapper?> getUpcomingMovie({Map<String, dynamic>? query}) async {
    final Response<MovieWrapper> response = await provider.getUpcomingMovie(path: Url.upcomingMovies, query: query);
    debugPrint(response.bodyString.toString());
    if (response.status.hasError) {
      debugPrint("UpComingMovieError: ${response.statusText}");
      return Future<MovieWrapper>.error(response.statusText!);
    } else {
      return response.body;
    }
  }
}
