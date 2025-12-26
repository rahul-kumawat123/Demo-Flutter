// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trending_movies_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TrendingMoviesResponse _$TrendingMoviesResponseFromJson(
  Map<String, dynamic> json,
) {
  return _TrendingMoviesResponse.fromJson(json);
}

/// @nodoc
mixin _$TrendingMoviesResponse {
  int get page => throw _privateConstructorUsedError;
  List<MovieModel> get results => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_pages')
  int get totalPages => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_results')
  int get totalResults => throw _privateConstructorUsedError;

  /// Serializes this TrendingMoviesResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrendingMoviesResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrendingMoviesResponseCopyWith<TrendingMoviesResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrendingMoviesResponseCopyWith<$Res> {
  factory $TrendingMoviesResponseCopyWith(
    TrendingMoviesResponse value,
    $Res Function(TrendingMoviesResponse) then,
  ) = _$TrendingMoviesResponseCopyWithImpl<$Res, TrendingMoviesResponse>;
  @useResult
  $Res call({
    int page,
    List<MovieModel> results,
    @JsonKey(name: 'total_pages') int totalPages,
    @JsonKey(name: 'total_results') int totalResults,
  });
}

/// @nodoc
class _$TrendingMoviesResponseCopyWithImpl<
  $Res,
  $Val extends TrendingMoviesResponse
>
    implements $TrendingMoviesResponseCopyWith<$Res> {
  _$TrendingMoviesResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrendingMoviesResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? results = null,
    Object? totalPages = null,
    Object? totalResults = null,
  }) {
    return _then(
      _value.copyWith(
            page: null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int,
            results: null == results
                ? _value.results
                : results // ignore: cast_nullable_to_non_nullable
                      as List<MovieModel>,
            totalPages: null == totalPages
                ? _value.totalPages
                : totalPages // ignore: cast_nullable_to_non_nullable
                      as int,
            totalResults: null == totalResults
                ? _value.totalResults
                : totalResults // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TrendingMoviesResponseImplCopyWith<$Res>
    implements $TrendingMoviesResponseCopyWith<$Res> {
  factory _$$TrendingMoviesResponseImplCopyWith(
    _$TrendingMoviesResponseImpl value,
    $Res Function(_$TrendingMoviesResponseImpl) then,
  ) = __$$TrendingMoviesResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int page,
    List<MovieModel> results,
    @JsonKey(name: 'total_pages') int totalPages,
    @JsonKey(name: 'total_results') int totalResults,
  });
}

/// @nodoc
class __$$TrendingMoviesResponseImplCopyWithImpl<$Res>
    extends
        _$TrendingMoviesResponseCopyWithImpl<$Res, _$TrendingMoviesResponseImpl>
    implements _$$TrendingMoviesResponseImplCopyWith<$Res> {
  __$$TrendingMoviesResponseImplCopyWithImpl(
    _$TrendingMoviesResponseImpl _value,
    $Res Function(_$TrendingMoviesResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TrendingMoviesResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? results = null,
    Object? totalPages = null,
    Object? totalResults = null,
  }) {
    return _then(
      _$TrendingMoviesResponseImpl(
        page: null == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int,
        results: null == results
            ? _value._results
            : results // ignore: cast_nullable_to_non_nullable
                  as List<MovieModel>,
        totalPages: null == totalPages
            ? _value.totalPages
            : totalPages // ignore: cast_nullable_to_non_nullable
                  as int,
        totalResults: null == totalResults
            ? _value.totalResults
            : totalResults // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TrendingMoviesResponseImpl implements _TrendingMoviesResponse {
  const _$TrendingMoviesResponseImpl({
    this.page = 1,
    final List<MovieModel> results = const [],
    @JsonKey(name: 'total_pages') this.totalPages = 1,
    @JsonKey(name: 'total_results') this.totalResults = 0,
  }) : _results = results;

  factory _$TrendingMoviesResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrendingMoviesResponseImplFromJson(json);

  @override
  @JsonKey()
  final int page;
  final List<MovieModel> _results;
  @override
  @JsonKey()
  List<MovieModel> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @override
  @JsonKey(name: 'total_results')
  final int totalResults;

  @override
  String toString() {
    return 'TrendingMoviesResponse(page: $page, results: $results, totalPages: $totalPages, totalResults: $totalResults)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrendingMoviesResponseImpl &&
            (identical(other.page, page) || other.page == page) &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    page,
    const DeepCollectionEquality().hash(_results),
    totalPages,
    totalResults,
  );

  /// Create a copy of TrendingMoviesResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrendingMoviesResponseImplCopyWith<_$TrendingMoviesResponseImpl>
  get copyWith =>
      __$$TrendingMoviesResponseImplCopyWithImpl<_$TrendingMoviesResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TrendingMoviesResponseImplToJson(this);
  }
}

abstract class _TrendingMoviesResponse implements TrendingMoviesResponse {
  const factory _TrendingMoviesResponse({
    final int page,
    final List<MovieModel> results,
    @JsonKey(name: 'total_pages') final int totalPages,
    @JsonKey(name: 'total_results') final int totalResults,
  }) = _$TrendingMoviesResponseImpl;

  factory _TrendingMoviesResponse.fromJson(Map<String, dynamic> json) =
      _$TrendingMoviesResponseImpl.fromJson;

  @override
  int get page;
  @override
  List<MovieModel> get results;
  @override
  @JsonKey(name: 'total_pages')
  int get totalPages;
  @override
  @JsonKey(name: 'total_results')
  int get totalResults;

  /// Create a copy of TrendingMoviesResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrendingMoviesResponseImplCopyWith<_$TrendingMoviesResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
