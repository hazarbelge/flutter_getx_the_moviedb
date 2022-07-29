import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/core/base/index.dart';
import 'package:flutter_getx_the_moviedb/models/index.dart';
import 'package:flutter_getx_the_moviedb/network/index.dart';
import 'package:get/get.dart';

abstract class IHomeMovieProvider {
  Future<Response<MovieWrapper>> getNowPlayingMovie({required String path, Map<String, dynamic>? query});

  Future<Response<MovieWrapper>> getPopularMovie({required String path, Map<String, dynamic>? query});

  Future<Response<MovieWrapper>> getTopRatedMovie({required String path, Map<String, dynamic>? query});

  Future<Response<MovieWrapper>> getUpcomingMovie({required String path, Map<String, dynamic>? query});
}

class HomeMovieProvider extends BaseProvider implements IHomeMovieProvider {
  @override
  InternalFinalCallback<void> get onStart {
    httpClient.defaultDecoder = (dynamic val) => MovieWrapper.fromJson(val as Map<String, dynamic>);
    return super.onStart;
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

class HomeMovieRepository extends BaseRepository<HomeMovieProvider> implements IHomeMovieRepository {
  HomeMovieRepository() : super(provider: HomeMovieProvider());

  @override
  Future<MovieWrapper?> getNowPlayingMovie({Map<String, dynamic>? query}) async {
    final Response<MovieWrapper> response = await provider.getNowPlayingMovie(path: Url.nowPlayingMovies, query: query);
    debugPrint("NowPlayingMoviesResponse: ${response.body}");
    if (response.status.hasError) {
      debugPrint("NowPlayingMovieError: ${response.statusText}");
      return Future<MovieWrapper>.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  @override
  Future<MovieWrapper?> getPopularMovie({Map<String, dynamic>? query}) async {
    final Response<MovieWrapper> response = await provider.getPopularMovie(path: Url.popularMovies, query: query);
    debugPrint("PopularMoviesResponse: ${response.body}");
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
    debugPrint("TopRatedMoviesResponse: ${response.body}");
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
    debugPrint("UpcomingMoviesResponse: ${response.body}");
    if (response.status.hasError) {
      debugPrint("UpComingMovieError: ${response.statusText}");
      return Future<MovieWrapper>.error(response.statusText!);
    } else {
      return response.body;
    }
  }
}
