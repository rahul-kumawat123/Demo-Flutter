import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';
import '../network/api_constants.dart';
import '../../models/cast/cast_model.dart';

/// Reusable actor card widget displaying a circular profile photo and name
class ActorCard extends StatelessWidget {
  final CastModel actor;
  final double photoSize;
  final double cardWidth;
  final VoidCallback? onTap;

  const ActorCard({
    super.key,
    required this.actor,
    this.photoSize = AppSpacing.spacing70,
    this.cardWidth = AppSpacing.spacing80,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: cardWidth,
        child: Column(
          children: [
            // Actor photo
            Container(
              width: photoSize,
              height: photoSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: AppSpacing.spacing8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: _buildPhoto(),
            ),
            gapH8,
            // Actor name
            Text(
              actor.displayName,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoto() {
    if (actor.profilePath != null) {
      return CachedNetworkImage(
        imageUrl: ApiConstants.getPosterUrl(actor.profilePath),
        fit: BoxFit.cover,
        placeholder: (context, url) => _buildPlaceholder(),
        errorWidget: (context, url, error) => _buildPlaceholder(),
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[700],
      child: const Icon(Icons.person, color: Colors.white54, size: 30),
    );
  }
}

