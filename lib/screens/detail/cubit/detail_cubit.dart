import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/cast/cast_model.dart';
import '../data/credits_repository.dart';
import '../data/genre_repository.dart';
import 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  final GenreRepository _genreRepository = GenreRepository();
  final CreditsRepository _creditsRepository = CreditsRepository();

  DetailCubit() : super(const DetailState.initial());

  Future<void> loadMovieDetails(int movieId) async {
    emit(const DetailState.loading());

    // Fetch genres and credits in parallel
    final results = await Future.wait([
      _genreRepository.getGenres(),
      _creditsRepository.getMovieCredits(movieId),
    ]);

    final genreResult = results[0];
    final creditsResult = results[1];

    // Handle errors
    String? errorMessage;

    genreResult.fold(
      (error) => errorMessage = error.message,
      (_) {},
    );

    creditsResult.fold(
      (error) => errorMessage ??= error.message,
      (_) {},
    );

    if (errorMessage != null) {
      emit(DetailState.error(errorMessage!));
      return;
    }

    // Extract successful data
    final genres = genreResult.fold(
      (_) => <int, String>{},
      (data) => data as Map<int, String>,
    );

    final cast = creditsResult.fold(
      (_) => <CastModel>[],
      (data) => data as List<CastModel>,
    );

    emit(DetailState.loaded(genres: genres, cast: cast));
  }

  List<String> getGenreNames(List<int> genreIds) {
    return state.maybeWhen(
      loaded: (genres, _) {
        return genreIds
            .where((id) => genres.containsKey(id))
            .map((id) => genres[id]!)
            .toList();
      },
      orElse: () => [],
    );
  }
}

