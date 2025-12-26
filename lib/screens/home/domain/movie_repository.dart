import 'package:dartz/dartz.dart';

import '../../../core/network/api_exceptions.dart';
import '../../../models/movie/trending_movies_response.dart';

abstract class MovieRepository {
  //movies fetching API
  Future<Either<ApiException, TrendingMoviesResponse>> getTrendingMovies(
    int page,
  );
}
