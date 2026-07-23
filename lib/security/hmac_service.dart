import 'dart:convert';

import 'package:crypto/crypto.dart';

/// Low-level HMAC-SHA256 operations.
///
/// Wraps the `crypto` package so the rest of the app never imports it directly.
/// SHA-256 is used because it is widely supported, fast on mobile, and
/// collision-resistant — the standard choice for request signing.
class HmacService {
  const HmacService();

  /// Returns the SHA-256 hash of [input] as a lowercase hex string.
  String sha256Hex(String input) {
    final digest = sha256.convert(utf8.encode(input));
    return digest.toString();
  }

  /// Computes HMAC-SHA256 of [message] using [secretKey], returned as hex.
  String computeHmacHex({required String message, required String secretKey}) {
    final hmac = Hmac(sha256, utf8.encode(secretKey));
    final digest = hmac.convert(utf8.encode(message));
    return digest.toString();
  }
}
