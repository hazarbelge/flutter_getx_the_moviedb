import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_getx_the_moviedb/models/index.dart';

class MovieWrapper extends Equatable {
  const MovieWrapper({
    this.page,
    this.totalResults,
    this.totalPages,
    this.results,
  });

  factory MovieWrapper.fromRawJson(String str) => MovieWrapper.fromJson(json.decode(str));

  factory MovieWrapper.fromJson(Map<String?, dynamic> json) {
    return MovieWrapper(
      page: json['page'],
      totalResults: json['total_results'],
      totalPages: json['total_pages'],
      results: json["results"] == null ? null : List<Movie>.from(json["results"].map((dynamic x) => Movie.fromJson(x))),
    );
  }

  final int? page;
  final int? totalResults;
  final int? totalPages;
  final List<Movie>? results;

  @override
  List<Object?> get props => <Object?>[
        page,
        totalResults,
        totalPages,
        results,
      ];
}

class Movie extends Equatable {
  const Movie({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genres,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  factory Movie.fromJson(Map<String?, dynamic> json) {
    return Movie(
      popularity: json['popularity'] == null ? 0.0 : json['popularity'].toDouble(),
      voteCount: json['vote_count'],
      video: json['video'],
      posterPath: json['poster_path'],
      id: json['id'],
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      genres: json["genres"] == null ? null : List<Genre>.from(json["genres"].map((dynamic x) => Genre.fromJson(x))),
      title: json['title'],
      voteAverage: json['vote_average'].toString(),
      overview: json['overview'],
      releaseDate: json['release_date'],
    );
  }

  final double? popularity;
  final int? voteCount;
  final bool? video;
  final String? posterPath;
  final int? id;
  final bool? adult;
  final String? backdropPath;
  final String? originalLanguage;
  final String? originalTitle;
  final List<Genre>? genres;
  final String? title;
  final String? voteAverage;
  final String? overview;
  final String? releaseDate;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => <String, dynamic>{
        "poster_path": posterPath,
        "adult": adult,
        "overview": overview,
        "release_date": releaseDate,
        "genres": genres != null ? List<dynamic>.from(genres!.map((Genre x) => x.toJson())) : null,
        "id": id,
        "original_title": originalTitle,
        "original_language": originalLanguage,
        "title": title,
        "backdrop_path": backdropPath,
        "popularity": popularity,
        "vote_count": voteCount,
        "video": video,
        "vote_average": voteAverage,
      };

  @override
  List<Object?> get props => <Object?>[
        popularity,
        voteCount,
        video,
        posterPath,
        id,
        adult,
        backdropPath,
        originalLanguage,
        originalTitle,
        genres,
        title,
        voteAverage,
        overview,
        releaseDate,
      ];
}
