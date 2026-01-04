import 'package:freezed_annotation/freezed_annotation.dart';

part 'cast_model.freezed.dart';
part 'cast_model.g.dart';

@freezed
class CastModel with _$CastModel {
  const CastModel._();

  const factory CastModel({
    required int id,
    String? name,
    @JsonKey(name: 'original_name') String? originalName,
    String? character,
    @JsonKey(name: 'profile_path') String? profilePath,
    @Default(0) int order,
  }) = _CastModel;

  factory CastModel.fromJson(Map<String, dynamic> json) =>
      _$CastModelFromJson(json);

  String get displayName => name ?? originalName ?? 'Unknown';
}

