import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../l10n/app_localizations.dart';
import '../cubit/favorites_cubit.dart';
import '../cubit/favorites_state.dart';
import '../../../core/widgets/favorite_movie_tile.dart';

class FavouritesTab extends StatelessWidget {
  const FavouritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocProvider(
      create: (_) => FavoritesCubit()..loadFavorites(),
      child: SafeArea(
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
              child: BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () => const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFE94560),
                      ),
                    ),
                    empty: () => _EmptyFavorites(),
                    error: (message) => Center(
                      child: Text(
                        message,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    loaded: (movies) => RefreshIndicator(
                      color: const Color(0xFFE94560),
                      onRefresh:
                      context.read<FavoritesCubit>().refresh,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.spacing16,
                        ),
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          return FavoriteMovieTile(
                            movie: movie,
                            onRemove: () => context
                                .read<FavoritesCubit>()
                                .removeFavorite(movie),
                            onTap: () => context.push(
                              '/movie-detail',
                              extra: movie,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
