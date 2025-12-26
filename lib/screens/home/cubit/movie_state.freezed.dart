// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MovieState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<MovieModel> carouselMovies,
      List<MovieModel> gridMovies,
      int currentPage,
      int totalPages,
      bool isLoadingMore,
    )
    loaded,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<MovieModel> carouselMovies,
      List<MovieModel> gridMovies,
      int currentPage,
      int totalPages,
      bool isLoadingMore,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<MovieModel> carouselMovies,
      List<MovieModel> gridMovies,
      int currentPage,
      int totalPages,
      bool isLoadingMore,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MovieInitial value) initial,
    required TResult Function(MovieLoading value) loading,
    required TResult Function(MovieLoaded value) loaded,
    required TResult Function(MovieError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MovieInitial value)? initial,
    TResult? Function(MovieLoading value)? loading,
    TResult? Function(MovieLoaded value)? loaded,
    TResult? Function(MovieError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MovieInitial value)? initial,
    TResult Function(MovieLoading value)? loading,
    TResult Function(MovieLoaded value)? loaded,
    TResult Function(MovieError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieStateCopyWith<$Res> {
  factory $MovieStateCopyWith(
    MovieState value,
    $Res Function(MovieState) then,
  ) = _$MovieStateCopyWithImpl<$Res, MovieState>;
}

/// @nodoc
class _$MovieStateCopyWithImpl<$Res, $Val extends MovieState>
    implements $MovieStateCopyWith<$Res> {
  _$MovieStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MovieState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$MovieInitialImplCopyWith<$Res> {
  factory _$$MovieInitialImplCopyWith(
    _$MovieInitialImpl value,
    $Res Function(_$MovieInitialImpl) then,
  ) = __$$MovieInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MovieInitialImplCopyWithImpl<$Res>
    extends _$MovieStateCopyWithImpl<$Res, _$MovieInitialImpl>
    implements _$$MovieInitialImplCopyWith<$Res> {
  __$$MovieInitialImplCopyWithImpl(
    _$MovieInitialImpl _value,
    $Res Function(_$MovieInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MovieState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MovieInitialImpl implements MovieInitial {
  const _$MovieInitialImpl();

  @override
  String toString() {
    return 'MovieState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MovieInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<MovieModel> carouselMovies,
      List<MovieModel> gridMovies,
      int currentPage,
      int totalPages,
      bool isLoadingMore,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<MovieModel> carouselMovies,
      List<MovieModel> gridMovies,
      int currentPage,
      int totalPages,
      bool isLoadingMore,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<MovieModel> carouselMovies,
      List<MovieModel> gridMovies,
      int currentPage,
      int totalPages,
      bool isLoadingMore,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MovieInitial value) initial,
    required TResult Function(MovieLoading value) loading,
    required TResult Function(MovieLoaded value) loaded,
    required TResult Function(MovieError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MovieInitial value)? initial,
    TResult? Function(MovieLoading value)? loading,
    TResult? Function(MovieLoaded value)? loaded,
    TResult? Function(MovieError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MovieInitial value)? initial,
    TResult Function(MovieLoading value)? loading,
    TResult Function(MovieLoaded value)? loaded,
    TResult Function(MovieError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class MovieInitial implements MovieState {
  const factory MovieInitial() = _$MovieInitialImpl;
}

/// @nodoc
abstract class _$$MovieLoadingImplCopyWith<$Res> {
  factory _$$MovieLoadingImplCopyWith(
    _$MovieLoadingImpl value,
    $Res Function(_$MovieLoadingImpl) then,
  ) = __$$MovieLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MovieLoadingImplCopyWithImpl<$Res>
    extends _$MovieStateCopyWithImpl<$Res, _$MovieLoadingImpl>
    implements _$$MovieLoadingImplCopyWith<$Res> {
  __$$MovieLoadingImplCopyWithImpl(
    _$MovieLoadingImpl _value,
    $Res Function(_$MovieLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MovieState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MovieLoadingImpl implements MovieLoading {
  const _$MovieLoadingImpl();

  @override
  String toString() {
    return 'MovieState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MovieLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<MovieModel> carouselMovies,
      List<MovieModel> gridMovies,
      int currentPage,
      int totalPages,
      bool isLoadingMore,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<MovieModel> carouselMovies,
      List<MovieModel> gridMovies,
      int currentPage,
      int totalPages,
      bool isLoadingMore,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<MovieModel> carouselMovies,
      List<MovieModel> gridMovies,
      int currentPage,
      int totalPages,
      bool isLoadingMore,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MovieInitial value) initial,
    required TResult Function(MovieLoading value) loading,
    required TResult Function(MovieLoaded value) loaded,
    required TResult Function(MovieError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MovieInitial value)? initial,
    TResult? Function(MovieLoading value)? loading,
    TResult? Function(MovieLoaded value)? loaded,
    TResult? Function(MovieError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MovieInitial value)? initial,
    TResult Function(MovieLoading value)? loading,
    TResult Function(MovieLoaded value)? loaded,
    TResult Function(MovieError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class MovieLoading implements MovieState {
  const factory MovieLoading() = _$MovieLoadingImpl;
}

/// @nodoc
abstract class _$$MovieLoadedImplCopyWith<$Res> {
  factory _$$MovieLoadedImplCopyWith(
    _$MovieLoadedImpl value,
    $Res Function(_$MovieLoadedImpl) then,
  ) = __$$MovieLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<MovieModel> carouselMovies,
    List<MovieModel> gridMovies,
    int currentPage,
    int totalPages,
    bool isLoadingMore,
  });
}

/// @nodoc
class __$$MovieLoadedImplCopyWithImpl<$Res>
    extends _$MovieStateCopyWithImpl<$Res, _$MovieLoadedImpl>
    implements _$$MovieLoadedImplCopyWith<$Res> {
  __$$MovieLoadedImplCopyWithImpl(
    _$MovieLoadedImpl _value,
    $Res Function(_$MovieLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MovieState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? carouselMovies = null,
    Object? gridMovies = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? isLoadingMore = null,
  }) {
    return _then(
      _$MovieLoadedImpl(
        carouselMovies: null == carouselMovies
            ? _value._carouselMovies
            : carouselMovies // ignore: cast_nullable_to_non_nullable
                  as List<MovieModel>,
        gridMovies: null == gridMovies
            ? _value._gridMovies
            : gridMovies // ignore: cast_nullable_to_non_nullable
                  as List<MovieModel>,
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPages: null == totalPages
            ? _value.totalPages
            : totalPages // ignore: cast_nullable_to_non_nullable
                  as int,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$MovieLoadedImpl implements MovieLoaded {
  const _$MovieLoadedImpl({
    required final List<MovieModel> carouselMovies,
    required final List<MovieModel> gridMovies,
    required this.currentPage,
    required this.totalPages,
    this.isLoadingMore = false,
  }) : _carouselMovies = carouselMovies,
       _gridMovies = gridMovies;

  final List<MovieModel> _carouselMovies;
  @override
  List<MovieModel> get carouselMovies {
    if (_carouselMovies is EqualUnmodifiableListView) return _carouselMovies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_carouselMovies);
  }

  final List<MovieModel> _gridMovies;
  @override
  List<MovieModel> get gridMovies {
    if (_gridMovies is EqualUnmodifiableListView) return _gridMovies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_gridMovies);
  }

  @override
  final int currentPage;
  @override
  final int totalPages;
  @override
  @JsonKey()
  final bool isLoadingMore;

  @override
  String toString() {
    return 'MovieState.loaded(carouselMovies: $carouselMovies, gridMovies: $gridMovies, currentPage: $currentPage, totalPages: $totalPages, isLoadingMore: $isLoadingMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieLoadedImpl &&
            const DeepCollectionEquality().equals(
              other._carouselMovies,
              _carouselMovies,
            ) &&
            const DeepCollectionEquality().equals(
              other._gridMovies,
              _gridMovies,
            ) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_carouselMovies),
    const DeepCollectionEquality().hash(_gridMovies),
    currentPage,
    totalPages,
    isLoadingMore,
  );

  /// Create a copy of MovieState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieLoadedImplCopyWith<_$MovieLoadedImpl> get copyWith =>
      __$$MovieLoadedImplCopyWithImpl<_$MovieLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<MovieModel> carouselMovies,
      List<MovieModel> gridMovies,
      int currentPage,
      int totalPages,
      bool isLoadingMore,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(
      carouselMovies,
      gridMovies,
      currentPage,
      totalPages,
      isLoadingMore,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<MovieModel> carouselMovies,
      List<MovieModel> gridMovies,
      int currentPage,
      int totalPages,
      bool isLoadingMore,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(
      carouselMovies,
      gridMovies,
      currentPage,
      totalPages,
      isLoadingMore,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<MovieModel> carouselMovies,
      List<MovieModel> gridMovies,
      int currentPage,
      int totalPages,
      bool isLoadingMore,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
        carouselMovies,
        gridMovies,
        currentPage,
        totalPages,
        isLoadingMore,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MovieInitial value) initial,
    required TResult Function(MovieLoading value) loading,
    required TResult Function(MovieLoaded value) loaded,
    required TResult Function(MovieError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MovieInitial value)? initial,
    TResult? Function(MovieLoading value)? loading,
    TResult? Function(MovieLoaded value)? loaded,
    TResult? Function(MovieError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MovieInitial value)? initial,
    TResult Function(MovieLoading value)? loading,
    TResult Function(MovieLoaded value)? loaded,
    TResult Function(MovieError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class MovieLoaded implements MovieState {
  const factory MovieLoaded({
    required final List<MovieModel> carouselMovies,
    required final List<MovieModel> gridMovies,
    required final int currentPage,
    required final int totalPages,
    final bool isLoadingMore,
  }) = _$MovieLoadedImpl;

  List<MovieModel> get carouselMovies;
  List<MovieModel> get gridMovies;
  int get currentPage;
  int get totalPages;
  bool get isLoadingMore;

  /// Create a copy of MovieState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MovieLoadedImplCopyWith<_$MovieLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MovieErrorImplCopyWith<$Res> {
  factory _$$MovieErrorImplCopyWith(
    _$MovieErrorImpl value,
    $Res Function(_$MovieErrorImpl) then,
  ) = __$$MovieErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$MovieErrorImplCopyWithImpl<$Res>
    extends _$MovieStateCopyWithImpl<$Res, _$MovieErrorImpl>
    implements _$$MovieErrorImplCopyWith<$Res> {
  __$$MovieErrorImplCopyWithImpl(
    _$MovieErrorImpl _value,
    $Res Function(_$MovieErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MovieState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$MovieErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$MovieErrorImpl implements MovieError {
  const _$MovieErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'MovieState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of MovieState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieErrorImplCopyWith<_$MovieErrorImpl> get copyWith =>
      __$$MovieErrorImplCopyWithImpl<_$MovieErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<MovieModel> carouselMovies,
      List<MovieModel> gridMovies,
      int currentPage,
      int totalPages,
      bool isLoadingMore,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<MovieModel> carouselMovies,
      List<MovieModel> gridMovies,
      int currentPage,
      int totalPages,
      bool isLoadingMore,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<MovieModel> carouselMovies,
      List<MovieModel> gridMovies,
      int currentPage,
      int totalPages,
      bool isLoadingMore,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MovieInitial value) initial,
    required TResult Function(MovieLoading value) loading,
    required TResult Function(MovieLoaded value) loaded,
    required TResult Function(MovieError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MovieInitial value)? initial,
    TResult? Function(MovieLoading value)? loading,
    TResult? Function(MovieLoaded value)? loaded,
    TResult? Function(MovieError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MovieInitial value)? initial,
    TResult Function(MovieLoading value)? loading,
    TResult Function(MovieLoaded value)? loaded,
    TResult Function(MovieError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class MovieError implements MovieState {
  const factory MovieError(final String message) = _$MovieErrorImpl;

  String get message;

  /// Create a copy of MovieState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MovieErrorImplCopyWith<_$MovieErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
