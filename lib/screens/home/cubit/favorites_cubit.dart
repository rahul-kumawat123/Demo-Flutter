import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/local/favorites_local_storage.dart';
import '../../../models/movie/movie_model.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(const FavoritesState.initial());

  Future<void> loadFavorites() async {
    emit(const FavoritesState.loading());

    try {
      final movies = await FavoritesLocalStorage.getFavoriteMovies();

      if (movies.isEmpty) {
        emit(const FavoritesState.empty());
      } else {
        emit(FavoritesState.loaded(movies: movies));
      }
    } catch (e) {
      emit(const FavoritesState.error('Failed to load favourites'));
    }
  }

  Future<void> removeFavorite(MovieModel movie) async {
    await FavoritesLocalStorage.removeFavorite(movie.id);
    await loadFavorites();
  }

  Future<void> refresh() async {
    await loadFavorites();
  }
}
