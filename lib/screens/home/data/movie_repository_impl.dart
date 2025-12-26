import 'package:dartz/dartz.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/api_exceptions.dart';
import '../../../core/network/api_service.dart';
import '../../../models/movie/trending_movies_response.dart';
import '../domain/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final ApiService _apiService;

  MovieRepositoryImpl({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  @override
  Future<Either<ApiException, TrendingMoviesResponse>> getTrendingMovies(
    int page,
  ) async {
    return _apiService.get<TrendingMoviesResponse>(
      endpoint: ApiEndpoints.getTrendingMoviesUrl(page),
      fromJson: TrendingMoviesResponse.fromJson,
    );
  }
}

