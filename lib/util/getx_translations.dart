import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetTranslations extends Translations {
  static const Locale fallbackLocale = Locale('tr', 'TR');

  @override
  Map<String, Map<String, String>> get keys => const <String, Map<String, String>>{
        'tr_TR': <String, String>{
          'app.title': 'Flutter TheMovieDB w/GetX',
          'app.movies.title': 'Filmler',
          'app.tv_series.title': 'Diziler',
          'movies.now_playing.icon': 'Vizyonda',
          'movies.popular.icon': 'Popüler',
          'movies.top_rated.icon': 'Sevilenler',
          'movies.upcoming.icon': 'Yakında',
          'tv_series.airing_today_tv.icon': 'Bugün',
          'tv_series.on_the_air_tv.icon': 'Vizyonda',
          'tv_series.popular_tv.icon': 'Popüler',
          'tv_series.top_rated_tv.icon': 'Sevilenler',
          'details.widget.rating': 'Puan',
          'details.grade': 'Oy Ver',
          'details.more': 'Daha fazla',
          'details.less': 'Daha az'
        },
        'en_US': <String, String>{
          'app.title': 'Flutter TheMovieDB w/GetX',
          'app.movies.title': 'Movies',
          'app.tv_series.title': 'Tv Series',
          'movies.now_playing.icon': 'Now Playing',
          'movies.popular.icon': 'Popular',
          'movies.top_rated.icon': 'Top Rated',
          'movies.upcoming.icon': 'Upcoming',
          'tv_series.airing_today_tv.icon': 'Airing Today',
          'tv_series.on_the_air_tv.icon': 'On The Air',
          'tv_series.popular_tv.icon': 'Popular',
          'tv_series.top_rated_tv.icon': 'Top Rated',
          'details.widget.rating': 'Rating',
          'details.grade': 'Grade',
          'details.more': 'More',
          'details.less': 'Less'
        },
      };
}
