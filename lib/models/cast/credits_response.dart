import 'package:freezed_annotation/freezed_annotation.dart';

import 'cast_model.dart';

part 'credits_response.freezed.dart';
part 'credits_response.g.dart';

@freezed
class CreditsResponse with _$CreditsResponse {
  const factory CreditsResponse({
    required int id,
    @Default([]) List<CastModel> cast,
  }) = _CreditsResponse;

  factory CreditsResponse.fromJson(Map<String, dynamic> json) =>
      _$CreditsResponseFromJson(json);
}

