// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'genre_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GenreResponse _$GenreResponseFromJson(Map<String, dynamic> json) {
  return _GenreResponse.fromJson(json);
}

/// @nodoc
mixin _$GenreResponse {
  List<GenreModel> get genres => throw _privateConstructorUsedError;

  /// Serializes this GenreResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GenreResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GenreResponseCopyWith<GenreResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenreResponseCopyWith<$Res> {
  factory $GenreResponseCopyWith(
    GenreResponse value,
    $Res Function(GenreResponse) then,
  ) = _$GenreResponseCopyWithImpl<$Res, GenreResponse>;
  @useResult
  $Res call({List<GenreModel> genres});
}

/// @nodoc
class _$GenreResponseCopyWithImpl<$Res, $Val extends GenreResponse>
    implements $GenreResponseCopyWith<$Res> {
  _$GenreResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GenreResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? genres = null}) {
    return _then(
      _value.copyWith(
            genres: null == genres
                ? _value.genres
                : genres // ignore: cast_nullable_to_non_nullable
                      as List<GenreModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GenreResponseImplCopyWith<$Res>
    implements $GenreResponseCopyWith<$Res> {
  factory _$$GenreResponseImplCopyWith(
    _$GenreResponseImpl value,
    $Res Function(_$GenreResponseImpl) then,
  ) = __$$GenreResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<GenreModel> genres});
}

/// @nodoc
class __$$GenreResponseImplCopyWithImpl<$Res>
    extends _$GenreResponseCopyWithImpl<$Res, _$GenreResponseImpl>
    implements _$$GenreResponseImplCopyWith<$Res> {
  __$$GenreResponseImplCopyWithImpl(
    _$GenreResponseImpl _value,
    $Res Function(_$GenreResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GenreResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? genres = null}) {
    return _then(
      _$GenreResponseImpl(
        genres: null == genres
            ? _value._genres
            : genres // ignore: cast_nullable_to_non_nullable
                  as List<GenreModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GenreResponseImpl implements _GenreResponse {
  const _$GenreResponseImpl({final List<GenreModel> genres = const []})
    : _genres = genres;

  factory _$GenreResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GenreResponseImplFromJson(json);

  final List<GenreModel> _genres;
  @override
  @JsonKey()
  List<GenreModel> get genres {
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genres);
  }

  @override
  String toString() {
    return 'GenreResponse(genres: $genres)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenreResponseImpl &&
            const DeepCollectionEquality().equals(other._genres, _genres));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_genres));

  /// Create a copy of GenreResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GenreResponseImplCopyWith<_$GenreResponseImpl> get copyWith =>
      __$$GenreResponseImplCopyWithImpl<_$GenreResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GenreResponseImplToJson(this);
  }
}

abstract class _GenreResponse implements GenreResponse {
  const factory _GenreResponse({final List<GenreModel> genres}) =
      _$GenreResponseImpl;

  factory _GenreResponse.fromJson(Map<String, dynamic> json) =
      _$GenreResponseImpl.fromJson;

  @override
  List<GenreModel> get genres;

  /// Create a copy of GenreResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GenreResponseImplCopyWith<_$GenreResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
