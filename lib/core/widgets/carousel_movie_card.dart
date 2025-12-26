import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';
import '../network/api_constants.dart';
import '../../models/movie/movie_model.dart';

class CarouselMovieCard extends StatelessWidget {
  final MovieModel movie;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;
  final VoidCallback? onTap;

  const CarouselMovieCard({
    super.key,
    required this.movie,
    required this.isFavorite,
    required this.onFavoritePressed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.spacing4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.spacing16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: AppSpacing.spacing10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Backdrop image
            CachedNetworkImage(
              imageUrl: ApiConstants.getBackdropUrl(movie.backdropPath),
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
                child: const Icon(
                  Icons.movie_outlined,
                  color: Colors.white54,
                  size: AppSpacing.spacing60,
                ),
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
                    Colors.black.withOpacity(0.8),
                  ],
                  stops: const [0.5, 1.0],
                ),
              ),
            ),
            // Content overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.spacing16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      movie.displayTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    gapH4,
                    // Badges row
                    Row(
                      children: [
                        // Adult/UA Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.spacing8,
                            vertical: AppSpacing.spacing2,
                          ),
                          decoration: BoxDecoration(
                            color: movie.adult ? Colors.red : Colors.green,
                            borderRadius: BorderRadius.circular(AppSpacing.spacing4),
                          ),
                          child: Text(
                            movie.contentRating,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        gapW8,
                        // Language Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.spacing8,
                            vertical: AppSpacing.spacing2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(AppSpacing.spacing4),
                          ),
                          child: Text(
                            movie.languageDisplay,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Favorite button (top right)
            Positioned(
              top: AppSpacing.spacing8,
              right: AppSpacing.spacing8,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: onFavoritePressed,
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite
                        ? const Color(0xFFE94560)
                        : Colors.white,
                    size: AppSpacing.spacing24,
                  ),
                  padding: const EdgeInsets.all(AppSpacing.spacing8),
                  constraints: const BoxConstraints(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
