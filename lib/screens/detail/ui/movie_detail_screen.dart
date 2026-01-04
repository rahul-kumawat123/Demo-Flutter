import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_flutter/utils/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/widgets/actor_card.dart';
import '../../../core/widgets/info_badge.dart';
import '../../../core/widgets/star_rating.dart';
import '../../../data/local/favorites_local_storage.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/cast/cast_model.dart';
import '../../../models/movie/movie_model.dart';
import '../cubit/detail_cubit.dart';
import '../cubit/detail_state.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieModel movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool _isFavorite = false;
  bool _isOverviewExpanded = false;

  @override
  void initState() {
    super.initState();
    _checkFavorite();
  }

  Future<void> _checkFavorite() async {
    final isFav = await FavoritesLocalStorage.isFavorite(widget.movie.id);
    setState(() {
      _isFavorite = isFav;
    });
  }

  Future<void> _toggleFavorite() async {
    final l10n = AppLocalizations.of(context);
    final isFav = await FavoritesLocalStorage.toggleFavorite(widget.movie);
    setState(() {
      _isFavorite = isFav;
    });
    (isFav ? l10n.addedToFavourites : l10n.removedFromFavourites).showToast();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailCubit()..loadMovieDetails(widget.movie.id),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
            ),
          ),
          child: CustomScrollView(
            slivers: [
              _buildAppBar(),
              SliverToBoxAdapter(
                child: _buildContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: AppSpacing.spacing250,
      pinned: true,
      backgroundColor: const Color(0xFF1A1A2E),
      leading: Container(
        margin: const EdgeInsets.all(AppSpacing.spacing8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(AppSpacing.spacing8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? const Color(0xFFE94560) : Colors.white,
            ),
            onPressed: _toggleFavorite,
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Backdrop image
            CachedNetworkImage(
              imageUrl: ApiConstants.getBackdropUrl(widget.movie.backdropPath),
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[800],
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[800],
                child: const Icon(Icons.movie, color: Colors.white54, size: 60),
              ),
            ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    const Color(0xFF1A1A2E).withOpacity(0.8),
                    const Color(0xFF1A1A2E),
                  ],
                  stops: const [0.0, 0.7, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Poster and Info Row
          _buildPosterAndInfo(),
          gapH24,

          // Genres
          BlocBuilder<DetailCubit, DetailState>(
            builder: (context, state) {
              return state.maybeWhen(
                loaded: (genres, _) => _buildGenres(genres),
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
          gapH24,

          // Story line
          Text(
            l10n.storyline,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          gapH8,
          _buildOverview(),
          gapH24,

          // Actors
          BlocBuilder<DetailCubit, DetailState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.spacing20),
                    child: CircularProgressIndicator(color: Color(0xFFE94560)),
                  ),
                ),
                loaded: (_, cast) => _buildActorsSection(cast),
                error: (message) => Padding(
                  padding: const EdgeInsets.all(AppSpacing.spacing16),
                  child: Text(
                    message,
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                  ),
                ),
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
          gapH32,
        ],
      ),
    );
  }

  Widget _buildPosterAndInfo() {
    final l10n = AppLocalizations.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Poster
        Container(
          width: AppSpacing.spacing120,
          height: AppSpacing.spacing160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.spacing12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: AppSpacing.spacing10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: CachedNetworkImage(
            imageUrl: ApiConstants.getPosterUrl(widget.movie.posterPath),
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Colors.grey[800],
              child: const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFE94560),
                  strokeWidth: 2,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[800],
              child: const Icon(Icons.movie, color: Colors.white54, size: 40),
            ),
          ),
        ),
        gapW16,

        // Movie Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                widget.movie.displayTitle,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              gapH8,

              // Rating with stars
              Row(
                children: [
                  Text(
                    widget.movie.formattedRating,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE94560),
                    ),
                  ),
                  gapW8,
                  StarRating(rating: widget.movie.voteAverage),
                ],
              ),
              gapH4,
              Text(
                l10n.ratings,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
              gapH12,

              // Stats Row
              _buildStatRow(
                l10n.popularity,
                widget.movie.popularityScale,
              ),
              gapH4,
              _buildStatRow(
                l10n.releaseDate,
                widget.movie.displayReleaseDate,
              ),
              gapH8,

              // Badges
              Row(
                children: [
                  InfoBadge.language(language: widget.movie.languageDisplay),
                  gapW8,
                  InfoBadge.contentRating(isAdult: widget.movie.adult),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildGenres(Map<int, String> genreMap) {
    final l10n = AppLocalizations.of(context);
    final genreNames = widget.movie.genreIds
        .where((id) => genreMap.containsKey(id))
        .map((id) => genreMap[id]!)
        .toList();

    if (genreNames.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.genres,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        gapH8,
        Wrap(
          spacing: AppSpacing.spacing8,
          runSpacing: AppSpacing.spacing8,
          children: genreNames.map((name) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.spacing12,
                vertical: AppSpacing.spacing6,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE94560).withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppSpacing.spacing20),
                border: Border.all(
                  color: const Color(0xFFE94560).withOpacity(0.5),
                ),
              ),
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildOverview() {
    final l10n = AppLocalizations.of(context);
    final overview = widget.movie.overview ?? '';

    if (overview.isEmpty) {
      return Text(
        'No overview available.',
        style: TextStyle(
          fontSize: 14,
          color: Colors.white.withOpacity(0.7),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          overview,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.8),
            height: 1.5,
          ),
          maxLines: _isOverviewExpanded ? null : 3,
          overflow: _isOverviewExpanded ? null : TextOverflow.ellipsis,
        ),
        if (overview.length > 150)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                setState(() {
                  _isOverviewExpanded = !_isOverviewExpanded;
                });
              },
              child: Text(
                _isOverviewExpanded ? l10n.less : l10n.more,
                style: const TextStyle(
                  color: Color(0xFFE94560),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildActorsSection(List<CastModel> cast) {
    final l10n = AppLocalizations.of(context);

    if (cast.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.actors,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        gapH12,
        SizedBox(
          height: AppSpacing.spacing120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: cast.length,
            separatorBuilder: (_, __) => gapW12,
            itemBuilder: (context, index) {
              return ActorCard(actor: cast[index]);
            },
          ),
        ),
      ],
    );
  }
}

