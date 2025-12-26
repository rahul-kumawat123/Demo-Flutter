class ApiEndpoints {
  ApiEndpoints._();

  static const String trendingMovies = '/trending/movie/week';

  static String getTrendingMoviesUrl(int page) {
    return '$trendingMovies?page=$page';
  }
}
