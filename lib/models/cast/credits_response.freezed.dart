// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credits_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CreditsResponse _$CreditsResponseFromJson(Map<String, dynamic> json) {
  return _CreditsResponse.fromJson(json);
}

/// @nodoc
mixin _$CreditsResponse {
  int get id => throw _privateConstructorUsedError;
  List<CastModel> get cast => throw _privateConstructorUsedError;

  /// Serializes this CreditsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreditsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreditsResponseCopyWith<CreditsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreditsResponseCopyWith<$Res> {
  factory $CreditsResponseCopyWith(
    CreditsResponse value,
    $Res Function(CreditsResponse) then,
  ) = _$CreditsResponseCopyWithImpl<$Res, CreditsResponse>;
  @useResult
  $Res call({int id, List<CastModel> cast});
}

/// @nodoc
class _$CreditsResponseCopyWithImpl<$Res, $Val extends CreditsResponse>
    implements $CreditsResponseCopyWith<$Res> {
  _$CreditsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreditsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? cast = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            cast: null == cast
                ? _value.cast
                : cast // ignore: cast_nullable_to_non_nullable
                      as List<CastModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreditsResponseImplCopyWith<$Res>
    implements $CreditsResponseCopyWith<$Res> {
  factory _$$CreditsResponseImplCopyWith(
    _$CreditsResponseImpl value,
    $Res Function(_$CreditsResponseImpl) then,
  ) = __$$CreditsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, List<CastModel> cast});
}

/// @nodoc
class __$$CreditsResponseImplCopyWithImpl<$Res>
    extends _$CreditsResponseCopyWithImpl<$Res, _$CreditsResponseImpl>
    implements _$$CreditsResponseImplCopyWith<$Res> {
  __$$CreditsResponseImplCopyWithImpl(
    _$CreditsResponseImpl _value,
    $Res Function(_$CreditsResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreditsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? cast = null}) {
    return _then(
      _$CreditsResponseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        cast: null == cast
            ? _value._cast
            : cast // ignore: cast_nullable_to_non_nullable
                  as List<CastModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreditsResponseImpl implements _CreditsResponse {
  const _$CreditsResponseImpl({
    required this.id,
    final List<CastModel> cast = const [],
  }) : _cast = cast;

  factory _$CreditsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreditsResponseImplFromJson(json);

  @override
  final int id;
  final List<CastModel> _cast;
  @override
  @JsonKey()
  List<CastModel> get cast {
    if (_cast is EqualUnmodifiableListView) return _cast;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cast);
  }

  @override
  String toString() {
    return 'CreditsResponse(id: $id, cast: $cast)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreditsResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._cast, _cast));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, const DeepCollectionEquality().hash(_cast));

  /// Create a copy of CreditsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreditsResponseImplCopyWith<_$CreditsResponseImpl> get copyWith =>
      __$$CreditsResponseImplCopyWithImpl<_$CreditsResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreditsResponseImplToJson(this);
  }
}

abstract class _CreditsResponse implements CreditsResponse {
  const factory _CreditsResponse({
    required final int id,
    final List<CastModel> cast,
  }) = _$CreditsResponseImpl;

  factory _CreditsResponse.fromJson(Map<String, dynamic> json) =
      _$CreditsResponseImpl.fromJson;

  @override
  int get id;
  @override
  List<CastModel> get cast;

  /// Create a copy of CreditsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreditsResponseImplCopyWith<_$CreditsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
