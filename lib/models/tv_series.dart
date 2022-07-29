import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_getx_the_moviedb/models/index.dart';

class TvSeriesWrapper extends Equatable {
  const TvSeriesWrapper({
    required this.page,
    required this.totalResults,
    required this.totalPages,
    required this.results,
  });

  factory TvSeriesWrapper.fromRawJson(String str) => TvSeriesWrapper.fromJson(json.decode(str));

  factory TvSeriesWrapper.fromJson(Map<String, dynamic> json) {
    return TvSeriesWrapper(
      page: json['page'],
      totalResults: json['total_results'],
      totalPages: json['total_pages'],
      results: List<TvSeries>.from(json["results"].map((dynamic x) => TvSeries.fromJson(x))),
    );
  }

  final int? page;
  final int? totalResults;
  final int? totalPages;
  final List<TvSeries>? results;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => <String, dynamic>{
        "page": page,
        "total_results": totalResults,
        "total_pages": totalPages,
        "results": results != null ? List<TvSeries>.from(results!.map((TvSeries x) => x.toJson())) : null,
      };

  @override
  List<Object?> get props => <Object?>[
        page,
        totalResults,
        totalPages,
        results,
      ];
}

class TvSeries extends Equatable {
  const TvSeries({
    this.id,
    this.posterPath,
    this.popularity,
    this.backdropPath,
    this.voteAverage,
    this.overview,
    this.firstAirDate,
    this.originCountry,
    this.genres,
    this.originalLanguage,
    this.voteCount,
    this.name,
    this.originalName,
  });

  factory TvSeries.fromRawJson(String str) => TvSeries.fromJson(json.decode(str));

  factory TvSeries.fromJson(Map<String, dynamic> json) {
    return TvSeries(
      posterPath: json["poster_path"],
      popularity: json["popularity"],
      id: json["id"],
      backdropPath: json["backdrop_path"],
      voteAverage: json["vote_average"].toString(),
      overview: json["overview"],
      firstAirDate: json["first_air_date"],
      originCountry: List<String>.from(json["origin_country"].map((dynamic x) => x)),
      genres: json["genres"] == null ? null : List<Genre>.from(json["genres"].map((dynamic x) => Genre.fromJson(x))),
      originalLanguage: json["original_language"],
      voteCount: json["vote_count"],
      name: json["name"],
      originalName: json["original_name"],
    );
  }

  final int? id;
  final String? posterPath;
  final double? popularity;
  final String? backdropPath;
  final String? voteAverage;
  final String? overview;
  final String? firstAirDate;
  final List<String>? originCountry;
  final List<Genre>? genres;
  final String? originalLanguage;
  final int? voteCount;
  final String? name;
  final String? originalName;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => <String, dynamic>{
        "poster_path": posterPath,
        "popularity": popularity,
        "id": id,
        "backdrop_path": backdropPath,
        "vote_average": voteAverage,
        "overview": overview,
        "first_air_date": firstAirDate,
        "origin_country": originCountry != null ? List<dynamic>.from(originCountry!.map((String x) => x)) : null,
        "genres": genres != null ? List<dynamic>.from(genres!.map((Genre x) => x.toJson())) : null,
        "original_language": originalLanguage,
        "vote_count": voteCount,
        "name": name,
        "original_name": originalName,
      };

  @override
  List<Object?> get props => <Object?>[
        id,
        posterPath,
        popularity,
        backdropPath,
        voteAverage,
        overview,
        firstAirDate,
        originCountry,
        genres,
        originalLanguage,
        voteCount,
        name,
        originalName,
      ];
}
