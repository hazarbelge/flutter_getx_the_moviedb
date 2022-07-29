import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/core/utils/index.dart';
import 'package:get/get.dart';

class TranslationsUtil extends Translations {
  static Locale? locale = LanguageHelper.getLocale();
  static const Locale fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => const <String, Map<String, String>>{
        'tr_TR': <String, String>{
          'app.title': 'Flutter TheMovieDB w/GetX',
          'app.movies.title': 'Filmler',
          'app.tv_series.title': 'Diziler',
          'app.something.went.wrong': "Bir şeyler yanlış gitti!",
          'app.try.later': "Lütfen sonra tekrar deneyiniz",
          "app.restart.required": "Bir şeyler yanlış gitti. Lütfen uygulamayı tekrardan başlatınız.",
          "app.no.internet": "İnternet bağlantısı bulunamadı.",
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
          'app.something.went.wrong': "Something went wrong!",
          'app.try.later': "Please try again later.",
          "app.restart.required": "Something went wrong. Please restart the app.",
          "app.no.internet": "Internet connection could not be found.",
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
