import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo_flutter/utils/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/carousel_movie_card.dart';
import '../../../core/widgets/movie_card.dart';
import '../../../data/local/favorites_local_storage.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/movie/movie_model.dart';
import '../cubit/movie_cubit.dart';
import '../cubit/movie_state.dart';

/// Home Tab - Movies with Carousel and Grid
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final ScrollController _scrollController = ScrollController();
  Set<int> _favoriteIds = {};

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadFavorites() async {
    final favorites = await FavoritesLocalStorage.getFavoriteIds();
    setState(() {
      _favoriteIds = favorites;
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<MovieCubit>().loadMoreMovies();
    }
  }

  Future<void> _toggleFavorite(MovieModel movie) async {
    final l10n = AppLocalizations.of(context);
    final isFav = await FavoritesLocalStorage.toggleFavorite(movie);
    setState(() {
      if (isFav) {
        _favoriteIds.add(movie.id);
      } else {
        _favoriteIds.remove(movie.id);
      }
    });
    (isFav ? l10n.addedToFavourites : l10n.removedFromFavourites).showToast();
  }

  void _navigateToDetail(MovieModel movie) {
    context.push('/movie-detail', extra: movie);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      child: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(
              child: CircularProgressIndicator(color: Color(0xFFE94560)),
            ),
            error: (message) => _buildErrorState(message),
            loaded: (
              carouselMovies,
              gridMovies,
              currentPage,
              totalPages,
              isLoadingMore,
            ) {
              return RefreshIndicator(
                onRefresh: () => context.read<MovieCubit>().refreshMovies(),
                color: const Color(0xFFE94560),
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    // Header
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.spacing16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.movies,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                l10n.searchComingSoon.showToast();
                              },
                              icon: const Icon(Icons.search, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Carousel
                    if (carouselMovies.isNotEmpty)
                      SliverToBoxAdapter(
                        child: _buildCarousel(carouselMovies),
                      ),

                    // Grid section header
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.spacing16,
                          AppSpacing.spacing24,
                          AppSpacing.spacing16,
                          AppSpacing.spacing12,
                        ),
                        child: Text(
                          l10n.trendingThisWeek,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    // Movies Grid
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.spacing16,
                      ),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                          crossAxisSpacing: AppSpacing.spacing12,
                          mainAxisSpacing: AppSpacing.spacing12,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final movie = gridMovies[index];
                            return MovieCard(
                              movie: movie,
                              isFavorite: _favoriteIds.contains(movie.id),
                              onFavoritePressed: () => _toggleFavorite(movie),
                              onTap: () => _navigateToDetail(movie),
                            );
                          },
                          childCount: gridMovies.length,
                        ),
                      ),
                    ),

                    // Loading more indicator
                    if (isLoadingMore)
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(AppSpacing.spacing16),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFFE94560),
                            ),
                          ),
                        ),
                      ),

                    // Bottom padding
                    const SliverToBoxAdapter(
                      child: SizedBox(height: AppSpacing.spacing20),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildCarousel(List<MovieModel> movies) {
    return CarouselSlider.builder(
      itemCount: movies.length,
      options: CarouselOptions(
        height: AppSpacing.spacing200,
        viewportFraction: 0.85,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
      itemBuilder: (context, index, realIndex) {
        final movie = movies[index];
        return CarouselMovieCard(
          movie: movie,
          isFavorite: _favoriteIds.contains(movie.id),
          onFavoritePressed: () => _toggleFavorite(movie),
          onTap: () => _navigateToDetail(movie),
        );
      },
    );
  }

  Widget _buildErrorState(String message) {
    final l10n = AppLocalizations.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.spacing32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: AppSpacing.spacing64,
              color: Colors.white.withOpacity(0.5),
            ),
            gapH16,
            Text(
              message,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            gapH24,
            ElevatedButton(
              onPressed: () => context.read<MovieCubit>().fetchMovies(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE94560),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.spacing12),
                ),
              ),
              child: Text(l10n.retry),
            ),
          ],
        ),
      ),
    );
  }
}

