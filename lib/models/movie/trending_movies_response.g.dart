// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trending_movies_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrendingMoviesResponseImpl _$$TrendingMoviesResponseImplFromJson(
  Map<String, dynamic> json,
) => _$TrendingMoviesResponseImpl(
  page: (json['page'] as num?)?.toInt() ?? 1,
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  totalPages: (json['total_pages'] as num?)?.toInt() ?? 1,
  totalResults: (json['total_results'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$TrendingMoviesResponseImplToJson(
  _$TrendingMoviesResponseImpl instance,
) => <String, dynamic>{
  'page': instance.page,
  'results': instance.results,
  'total_pages': instance.totalPages,
  'total_results': instance.totalResults,
};
