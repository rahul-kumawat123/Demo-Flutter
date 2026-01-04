// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GenreResponseImpl _$$GenreResponseImplFromJson(Map<String, dynamic> json) =>
    _$GenreResponseImpl(
      genres:
          (json['genres'] as List<dynamic>?)
              ?.map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$GenreResponseImplToJson(_$GenreResponseImpl instance) =>
    <String, dynamic>{'genres': instance.genres};
