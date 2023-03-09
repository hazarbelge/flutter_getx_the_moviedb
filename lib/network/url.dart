class Url {
  //API key
  static const String apiKey = "YOUR.API_KEY";

  //Base URLs
  static const String movieDbBaseUrl = 'https://api.themoviedb.org/3';

  //Authentication URLs
  static const String sessionIdUrl = '/authentication/guest_session/new';
  static String? guestSessionId;

  //Logo & Background Images Path&Urls
  static const String appLogoUrl = "https://www.themoviedb.org/assets/2/apple-touch-icon-cfba7699efe7a742de25c28e08c38525f19381d31087c69e89d6bcb8e3c0ddfa.png";
  static const String appLogoPath = "assets/icons/app_logo.png";
  static const String backgroundUrl = "";

  //Movies URLs
  static const String latestMovie = '/movie/latest';
  static const String nowPlayingMovies = '/movie/now_playing';
  static const String popularMovies = '/movie/popular';
  static const String topRatedMovies = '/movie/top_rated';
  static const String upcomingMovies = '/movie/upcoming';

  static String rateMovie(int movieId) => '/movie/$movieId/rating';

  //TVs URLs
  static const String latestTv = '/tv/latest';
  static const String airingTodayTv = '/tv/airing_today';
  static const String onTheAirTv = '/tv/on_the_air';
  static const String popularTv = '/tv/popular';
  static const String topRatedTv = '/tv/top_rated';

  static String rateTV(int tvId) => '/tv/$tvId/rating';

  //About Me&App
  static const String authorProfile = 'https://www.linkedin.com/in/hazarbelge/';
  static const String emailUrl = 'mailto:hazarbelge@gmail.com?subject=About Flutter The Movie DB with GetX!';
  static const String appSource = 'https://github.com/hazarbelge/flutter_getx_the_moviedb';
}
