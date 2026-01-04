import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/cast/cast_model.dart';

part 'detail_state.freezed.dart';

@freezed
class DetailState with _$DetailState {
  const factory DetailState.initial() = _Initial;

  const factory DetailState.loading() = _Loading;

  const factory DetailState.loaded({
    required Map<int, String> genres,
    required List<CastModel> cast,
  }) = _Loaded;

  const factory DetailState.error(String message) = _Error;
}

