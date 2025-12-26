import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/movie/movie_model.dart';

part 'movie_state.freezed.dart';

@freezed
class MovieState with _$MovieState {
  const factory MovieState.initial() = MovieInitial;
  const factory MovieState.loading() = MovieLoading;
  const factory MovieState.loaded({
    required List<MovieModel> carouselMovies,
    required List<MovieModel> gridMovies,
    required int currentPage,
    required int totalPages,
    @Default(false) bool isLoadingMore,
  }) = MovieLoaded;
  const factory MovieState.error(String message) = MovieError;
}

