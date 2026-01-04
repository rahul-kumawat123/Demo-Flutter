// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CastModelImpl _$$CastModelImplFromJson(Map<String, dynamic> json) =>
    _$CastModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      originalName: json['original_name'] as String?,
      character: json['character'] as String?,
      profilePath: json['profile_path'] as String?,
      order: (json['order'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$CastModelImplToJson(_$CastModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'original_name': instance.originalName,
      'character': instance.character,
      'profile_path': instance.profilePath,
      'order': instance.order,
    };
