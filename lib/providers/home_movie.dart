import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

import '../../models/index.dart';
import '../../util/index.dart';

abstract class IHomeMovieProvider {
  Future<Response<MovieWrapper>> getNowPlayingMovie(String path);

  Future<Response<MovieWrapper>> getPopularMovie(String path);

  Future<Response<MovieWrapper>> getTopRatedMovie(String path);

  Future<Response<MovieWrapper>> getUpcomingMovie(String path);
}

class HomeMovieProvider extends GetConnect implements IHomeMovieProvider {
  @override
  void onInit() {
    httpClient.defaultDecoder = (dynamic val) => MovieWrapper.fromJson(val as Map<String, dynamic>);
    httpClient.baseUrl = Url.movieDbBaseUrl;

    httpClient.addRequestModifier((Request<dynamic> request) {
      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      debugPrint("${request.url.path}/${request.url.host}");
      return request;
    });
  }

  @override
  Future<Response<MovieWrapper>> getNowPlayingMovie(String path) => get(path);

  @override
  Future<Response<MovieWrapper>> getPopularMovie(String path) => get(path);

  @override
  Future<Response<MovieWrapper>> getTopRatedMovie(String path) => get(path);

  @override
  Future<Response<MovieWrapper>> getUpcomingMovie(String path) => get(path);
}

abstract class IHomeMovieRepository {
  Future<MovieWrapper?> getNowPlayingMovie();

  Future<MovieWrapper?> getPopularMovie();

  Future<MovieWrapper?> getTopRatedMovie();

  Future<MovieWrapper?> getUpcomingMovie();
}

class HomeMovieRepository implements IHomeMovieRepository {
  HomeMovieRepository({
    required this.provider,
  });

  final IHomeMovieProvider provider;

  @override
  Future<MovieWrapper?> getNowPlayingMovie() async {
    final Response<MovieWrapper> response = await provider.getNowPlayingMovie(Url.nowPlayingMovies);
    debugPrint(response.bodyString.toString());
    if (response.status.hasError) {
      return Future<MovieWrapper>.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  @override
  Future<MovieWrapper?> getPopularMovie() async {
    final Response<MovieWrapper> response = await provider.getPopularMovie(Url.popularMovies);
    debugPrint(response.bodyString.toString());
    if (response.status.hasError) {
      return Future<MovieWrapper>.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  @override
  Future<MovieWrapper?> getTopRatedMovie() async {
    final Response<MovieWrapper> response = await provider.getTopRatedMovie(Url.topRatedMovies);
    debugPrint(response.bodyString.toString());
    if (response.status.hasError) {
      return Future<MovieWrapper>.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  @override
  Future<MovieWrapper?> getUpcomingMovie() async {
    final Response<MovieWrapper> response = await provider.getUpcomingMovie(Url.upcomingMovies);
    debugPrint(response.bodyString.toString());
    if (response.status.hasError) {
      return Future<MovieWrapper>.error(response.statusText!);
    } else {
      return response.body;
    }
  }
}
