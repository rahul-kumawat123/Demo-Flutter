import 'package:freezed_annotation/freezed_annotation.dart';

import 'genre_model.dart';

part 'genre_response.freezed.dart';
part 'genre_response.g.dart';

@freezed
class GenreResponse with _$GenreResponse {
  const factory GenreResponse({
    @Default([]) List<GenreModel> genres,
  }) = _GenreResponse;

  factory GenreResponse.fromJson(Map<String, dynamic> json) =>
      _$GenreResponseFromJson(json);
}

