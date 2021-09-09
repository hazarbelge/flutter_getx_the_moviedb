import 'dart:convert';

class MovieWrapper {
  MovieWrapper({
    required this.page,
    required this.totalResults,
    required this.totalPages,
    required this.results,
  });

  factory MovieWrapper.fromRawJson(String str) => MovieWrapper.fromJson(json.decode(str));

  factory MovieWrapper.fromJson(Map<String, dynamic> json) {
    return MovieWrapper(
      page: json['page'],
      totalResults: json['total_results'],
      totalPages: json['total_pages'],
      results: List<Movie>.from(json["results"].map((dynamic x) => Movie.fromJson(x))),
    );
  }

  int page;
  final int totalResults;
  final int totalPages;
  final List<Movie> results;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => <String, dynamic>{
        "page": page,
        "total_results": totalResults,
        "total_pages": totalPages,
        "results": List<Movie>.from(results.map((Movie x) => x.toJson())),
      };
}

class Movie {
  const Movie({
    required this.id,
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  factory Movie.fromRawJson(String str) => Movie.fromJson(json.decode(str));

  factory Movie.fromJson(Map<String, dynamic> json) {
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
      genreIds: json['genre_ids'].cast<int>(),
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
  final int id;
  final bool? adult;
  final String? backdropPath;
  final String? originalLanguage;
  final String? originalTitle;
  final List<int>? genreIds;
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
        "genre_ids": genreIds != null ? List<dynamic>.from(genreIds!.map((int x) => x)) : null,
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
}
