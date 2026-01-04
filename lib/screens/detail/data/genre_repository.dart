import 'package:dartz/dartz.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/api_exceptions.dart';
import '../../../core/network/api_service.dart';
import '../../../models/genre/genre_model.dart';
import '../../../models/genre/genre_response.dart';

class GenreRepository {
  final ApiService _apiService = ApiService();

  // Cache for genres - fetched once and reused
  static Map<int, String>? _genreCache;

  Future<Either<ApiException, Map<int, String>>> getGenres() async {
    // Return cached genres if available
    if (_genreCache != null) {
      return Right(_genreCache!);
    }

    final result = await _apiService.get<GenreResponse>(
      endpoint: ApiEndpoints.genreList,
      fromJson: (json) => GenreResponse.fromJson(json),
    );

    return result.fold(
      (error) => Left(error),
      (response) {
        // Convert list to map and cache it
        _genreCache = {
          for (final genre in response.genres) genre.id: genre.name
        };
        return Right(_genreCache!);
      },
    );
  }

  List<String> getGenreNames(List<int> genreIds) {
    if (_genreCache == null) return [];
    return genreIds
        .where((id) => _genreCache!.containsKey(id))
        .map((id) => _genreCache![id]!)
        .toList();
  }

  static void clearCache() {
    _genreCache = null;
  }
}

