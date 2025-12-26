import 'package:freezed_annotation/freezed_annotation.dart';

import 'movie_model.dart';

part 'trending_movies_response.freezed.dart';
part 'trending_movies_response.g.dart';

@freezed
class TrendingMoviesResponse with _$TrendingMoviesResponse {
  const factory TrendingMoviesResponse({
    @Default(1) int page,
    @Default([]) List<MovieModel> results,
    @JsonKey(name: 'total_pages') @Default(1) int totalPages,
    @JsonKey(name: 'total_results') @Default(0) int totalResults,
  }) = _TrendingMoviesResponse;

  factory TrendingMoviesResponse.fromJson(Map<String, dynamic> json) =>
      _$TrendingMoviesResponseFromJson(json);
}
