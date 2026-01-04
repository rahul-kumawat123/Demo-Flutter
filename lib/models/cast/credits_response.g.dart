// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credits_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreditsResponseImpl _$$CreditsResponseImplFromJson(
  Map<String, dynamic> json,
) => _$CreditsResponseImpl(
  id: (json['id'] as num).toInt(),
  cast:
      (json['cast'] as List<dynamic>?)
          ?.map((e) => CastModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$CreditsResponseImplToJson(
  _$CreditsResponseImpl instance,
) => <String, dynamic>{'id': instance.id, 'cast': instance.cast};
