import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
class MovieModel with _$MovieModel {
  const MovieModel._();

  const factory MovieModel({
    required int id,
    String? title,
    String? name,
    String? overview,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @Default(false) bool adult,
    @JsonKey(name: 'original_language') String? originalLanguage,
    @Default(0.0) double popularity,
    @JsonKey(name: 'release_date') String? releaseDate,
    @JsonKey(name: 'first_air_date') String? firstAirDate,
    @JsonKey(name: 'vote_average') @Default(0.0) double voteAverage,
    @JsonKey(name: 'vote_count') @Default(0) int voteCount,
    @JsonKey(name: 'media_type') String? mediaType,
    @JsonKey(name: 'genre_ids') @Default([]) List<int> genreIds,
  }) = _MovieModel;

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  String get displayTitle => title ?? name ?? 'Unknown';

  String get displayReleaseDate => releaseDate ?? firstAirDate ?? 'Unknown';

  String get formattedRating => voteAverage.toStringAsFixed(1);

  String get popularityScale =>
      (popularity / 100 * 10).clamp(0, 10).toStringAsFixed(1);

  String get contentRating => adult ? 'A' : 'U/A';

  String get languageDisplay => (originalLanguage ?? 'EN').toUpperCase();
}
