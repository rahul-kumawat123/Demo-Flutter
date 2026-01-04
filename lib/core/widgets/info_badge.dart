import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';

/// Reusable badge widget for displaying labels like language, content rating, etc.
class InfoBadge extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  const InfoBadge({
    super.key,
    required this.text,
    required this.backgroundColor,
    this.textColor = Colors.white,
    this.fontSize = 11,
    this.padding,
    this.borderRadius = AppSpacing.spacing4,
  });

  /// Factory constructor for content rating badge (Adult/U-A)
  factory InfoBadge.contentRating({
    Key? key,
    required bool isAdult,
  }) {
    return InfoBadge(
      key: key,
      text: isAdult ? 'A' : 'U/A',
      backgroundColor: isAdult ? Colors.red : Colors.green,
    );
  }

  /// Factory constructor for language badge
  factory InfoBadge.language({
    Key? key,
    required String language,
  }) {
    return InfoBadge(
      key: key,
      text: language.toUpperCase(),
      backgroundColor: Colors.white.withOpacity(0.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: AppSpacing.spacing8,
            vertical: AppSpacing.spacing4,
          ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

