import 'package:demo_flutter/utils/common_toast.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/movie_card.dart';
import '../../../data/local/favorites_local_storage.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/movie/movie_model.dart';

/// Favourites Tab - Shows user's favorite movies
class FavouritesTab extends StatefulWidget {
  const FavouritesTab({super.key});

  @override
  State<FavouritesTab> createState() => _FavouritesTabState();
}

class _FavouritesTabState extends State<FavouritesTab> {
  List<MovieModel> _favorites = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    setState(() => _isLoading = true);
    final favorites = await FavoritesLocalStorage.getFavoriteMovies();
    setState(() {
      _favorites = favorites;
      _isLoading = false;
    });
  }

  Future<void> _removeFavorite(MovieModel movie) async {
    final l10n = AppLocalizations.of(context);
    await FavoritesLocalStorage.removeFavorite(movie.id);
    await _loadFavorites();
    l10n.removedFromFavourites.showToast();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.spacing16),
            child: Text(
              l10n.favourites,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFFE94560)),
                  )
                : _favorites.isEmpty
                    ? _buildEmptyState()
                    : RefreshIndicator(
                        onRefresh: _loadFavorites,
                        color: const Color(0xFFE94560),
                        child: GridView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.spacing16,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.65,
                            crossAxisSpacing: AppSpacing.spacing12,
                            mainAxisSpacing: AppSpacing.spacing12,
                          ),
                          itemCount: _favorites.length,
                          itemBuilder: (context, index) {
                            final movie = _favorites[index];
                            return MovieCard(
                              movie: movie,
                              isFavorite: true,
                              onFavoritePressed: () => _removeFavorite(movie),
                              onTap: () {
                                l10n.movieDetailsComingSoon.showToast();
                              },
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    final l10n = AppLocalizations.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_outline,
            size: AppSpacing.spacing80,
            color: Colors.white.withOpacity(0.3),
          ),
          gapH16,
          Text(
            l10n.noFavouritesYet,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
          gapH8,
          Text(
            l10n.addMoviesToFavourites,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

