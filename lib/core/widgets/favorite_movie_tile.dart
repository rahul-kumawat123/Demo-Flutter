import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/network/api_constants.dart';
import '../../../models/movie/movie_model.dart';

class FavoriteMovieTile extends StatelessWidget {
  final MovieModel movie;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  const FavoriteMovieTile({
    super.key,
    required this.movie,
    required this.onRemove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 130,
        margin: const EdgeInsets.only(bottom: AppSpacing.spacing12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.spacing16),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.08),
              Colors.white.withOpacity(0.02),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Blurred background
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.spacing16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: const SizedBox(),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(AppSpacing.spacing12),
              child: Row(
                children: [
                  // Poster
                  ClipRRect(
                    borderRadius:
                    BorderRadius.circular(AppSpacing.spacing12),
                    child: CachedNetworkImage(
                      width: 80,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl:
                      ApiConstants.getPosterUrl(movie.posterPath),
                    ),
                  ),

                  gapW12,

                  // Title + rating
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          movie.displayTitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        gapH8,
                        Text(
                          'Rating: ${movie.formattedRating}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Favorite icon
                  IconButton(
                    onPressed: onRemove,
                    icon: const Icon(
                      Icons.favorite,
                      color: Color(0xFFE94560),
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
