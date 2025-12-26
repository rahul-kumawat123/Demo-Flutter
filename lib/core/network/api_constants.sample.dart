/// TMDB API Configuration
///
/// To set up the project:
/// 1. Copy this file and rename it to `api_constants.dart`
/// 2. Replace the placeholder values with your TMDB API credentials
/// 3. Get your free API key from: https://www.themoviedb.org/settings/api
///
/// ⚠️ IMPORTANT: Never commit `api_constants.dart` to version control!
/// The file is already added to .gitignore for your safety.

class ApiConstants {
  ApiConstants._();

  // TMDB API Configuration
  // Get your API key from: https://www.themoviedb.org/settings/api
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = 'YOUR_TMDB_API_KEY_HERE';
  static const String bearerToken = 'YOUR_TMDB_BEARER_TOKEN_HERE';

  // Image URLs (these can remain as-is)
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p';
  static const String posterSize = '/w500';
  static const String backdropSize = '/w780';

  // Helper methods
  static String getPosterUrl(String? posterPath) {
    if (posterPath == null || posterPath.isEmpty) {
      return '';
    }
    return '$imageBaseUrl$posterSize$posterPath';
  }

  static String getBackdropUrl(String? backdropPath) {
    if (backdropPath == null || backdropPath.isEmpty) {
      return '';
    }
    return '$imageBaseUrl$backdropSize$backdropPath';
  }
}

