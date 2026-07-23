import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../security/interceptors/hmac_interceptor.dart';

/// JSONPlaceholder API configuration for the HMAC demo.
class DemoApiConstants {
  DemoApiConstants._();

  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String usersEndpoint = '/users';
  static const String postsEndpoint = '/posts';
}

/// Dedicated Dio client for the HMAC security POC.
///
/// Separate from the TMDB [ApiService] so HMAC headers never leak into
/// the movie browsing flow. Two instances are provided:
/// - [createPlainClient] — no signing (normal GET/POST demos).
/// - [createHmacClient] — includes [HmacInterceptor] for signed requests.
class DemoApiClient {
  DemoApiClient._();

  static Dio createPlainClient() {
    return _buildDio();
  }

  static Dio createHmacClient() {
    final dio = _buildDio();
    dio.interceptors.add(HmacInterceptor());
    return dio;
  }

  static Dio _buildDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: DemoApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Request/response logging leaks HMAC signatures and headers, so restrict
    // it to debug builds only.
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (object) => debugPrint('HMAC-DEMO: $object'),
        ),
      );
    }

    return dio;
  }
}
