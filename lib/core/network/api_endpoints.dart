class ApiEndpoints {
  ApiEndpoints._();

  // Trending Movies
  static const String trendingMovies = '/trending/movie/week';

  static String getTrendingMoviesUrl(int page) {
    return '$trendingMovies?page=$page';
  }

  // Genre List
  static const String genreList = '/genre/movie/list';

  // Movie Credits (Cast)
  static String getMovieCredits(int movieId) {
    return '/movie/$movieId/credits';
  }
}
