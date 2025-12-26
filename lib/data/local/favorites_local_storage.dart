import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/movie/movie_model.dart';

class FavoritesLocalStorage {
  static const String _favoritesKey = 'favorite_movies';

  static Future<Set<int>> getFavoriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesList = prefs.getStringList(_favoritesKey) ?? [];
    return favoritesList.map((id) => int.parse(id)).toSet();
  }

  static Future<bool> isFavorite(int movieId) async {
    final favoriteIds = await getFavoriteIds();
    return favoriteIds.contains(movieId);
  }

  static Future<void> addFavorite(MovieModel movie) async {
    final prefs = await SharedPreferences.getInstance();

    // Save to favorites ID list
    final favoriteIds = await getFavoriteIds();
    favoriteIds.add(movie.id);
    await prefs.setStringList(
      _favoritesKey,
      favoriteIds.map((id) => id.toString()).toList(),
    );

    await _saveMovieDetails(movie);
  }

  static Future<void> removeFavorite(int movieId) async {
    final prefs = await SharedPreferences.getInstance();

    // Remove from favorites ID list
    final favoriteIds = await getFavoriteIds();
    favoriteIds.remove(movieId);
    await prefs.setStringList(
      _favoritesKey,
      favoriteIds.map((id) => id.toString()).toList(),
    );

    // Remove movie details
    await prefs.remove('movie_$movieId');
  }

  static Future<bool> toggleFavorite(MovieModel movie) async {
    final isFav = await isFavorite(movie.id);
    if (isFav) {
      await removeFavorite(movie.id);
      return false;
    } else {
      await addFavorite(movie);
      return true;
    }
  }

  static Future<List<MovieModel>> getFavoriteMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = await getFavoriteIds();

    final movies = <MovieModel>[];
    for (final id in favoriteIds) {
      final movieJson = prefs.getString('movie_$id');
      if (movieJson != null) {
        movies.add(MovieModel.fromJson(jsonDecode(movieJson)));
      }
    }
    return movies;
  }

  static Future<void> _saveMovieDetails(MovieModel movie) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('movie_${movie.id}', jsonEncode(movie.toJson()));
  }

  static Future<void> clearAllFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = await getFavoriteIds();

    // Remove all movie details
    for (final id in favoriteIds) {
      await prefs.remove('movie_$id');
    }

    // Clear favorites list
    await prefs.remove(_favoritesKey);
  }
}
