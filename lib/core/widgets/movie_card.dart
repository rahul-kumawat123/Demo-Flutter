import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';
import '../network/api_constants.dart';
import '../../models/movie/movie_model.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;
  final VoidCallback? onTap;

  const MovieCard({
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
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppSpacing.spacing12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail with badges
            Expanded(
              flex: 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Movie poster
                  CachedNetworkImage(
                    imageUrl: ApiConstants.getPosterUrl(movie.posterPath),
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
                        size: AppSpacing.spacing40,
                      ),
                    ),
                  ),
                  // Adult/UA Badge (top left)
                  Positioned(
                    top: AppSpacing.spacing8,
                    left: AppSpacing.spacing8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.spacing6,
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
                  ),
                  // Language Badge (top right next to favorite)
                  Positioned(
                    top: AppSpacing.spacing8,
                    right: AppSpacing.spacing40,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.spacing6,
                        vertical: AppSpacing.spacing2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
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
                  ),
                  // Favorite Icon (top right)
                  Positioned(
                    top: AppSpacing.spacing4,
                    right: AppSpacing.spacing4,
                    child: IconButton(
                      onPressed: onFavoritePressed,
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? const Color(0xFFE94560) : Colors.white,
                        size: AppSpacing.spacing24,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ],
              ),
            ),
            // Title section
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.spacing8),
                child: Text(
                  movie.displayTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
