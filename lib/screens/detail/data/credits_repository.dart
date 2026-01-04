import 'package:dartz/dartz.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/api_exceptions.dart';
import '../../../core/network/api_service.dart';
import '../../../models/cast/cast_model.dart';
import '../../../models/cast/credits_response.dart';

class CreditsRepository {
  final ApiService _apiService = ApiService();

  Future<Either<ApiException, List<CastModel>>> getMovieCredits(
    int movieId, {
    int limit = 10,
  }) async {
    final result = await _apiService.get<CreditsResponse>(
      endpoint: ApiEndpoints.getMovieCredits(movieId),
      fromJson: (json) => CreditsResponse.fromJson(json),
    );

    return result.fold(
      (error) => Left(error),
      (response) {
        // Sort by order and take top cast members
        final sortedCast = List<CastModel>.from(response.cast)
          ..sort((a, b) => a.order.compareTo(b.order));
        return Right(sortedCast.take(limit).toList());
      },
    );
  }
}

