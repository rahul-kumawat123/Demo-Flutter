import 'package:flutter/material.dart';

/// Reusable star rating widget that displays a 5-star rating
/// based on a 0-10 scale rating value
class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  final Color activeColor;
  final Color inactiveColor;

  const StarRating({
    super.key,
    required this.rating,
    this.size = 16,
    this.activeColor = const Color(0xFFE94560),
    this.inactiveColor = const Color(0x4DFFFFFF), // Colors.white.withOpacity(0.3)
  });

  @override
  Widget build(BuildContext context) {
    // Convert 0-10 rating to 0-5 stars
    final normalizedRating = rating / 2;
    final fullStars = normalizedRating.floor();
    final hasHalfStar = normalizedRating - fullStars >= 0.5;
    final emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(
          fullStars,
          (_) => Icon(Icons.star, color: activeColor, size: size),
        ),
        if (hasHalfStar)
          Icon(Icons.star_half, color: activeColor, size: size),
        ...List.generate(
          emptyStars,
          (_) => Icon(Icons.star_border, color: inactiveColor, size: size),
        ),
      ],
    );
  }
}

