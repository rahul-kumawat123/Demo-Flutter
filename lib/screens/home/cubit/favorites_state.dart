import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../models/movie/movie_model.dart';

part 'favorites_state.freezed.dart';

@freezed
class FavoritesState with _$FavoritesState {
  const factory FavoritesState.initial() = FavoritesInitial;

  const factory FavoritesState.loading() = FavoritesLoading;

  const factory FavoritesState.loaded({
    required List<MovieModel> movies,
  }) = FavoritesLoaded;

  const factory FavoritesState.empty() = FavoritesEmpty;

  const factory FavoritesState.error(String message) = FavoritesError;
}
