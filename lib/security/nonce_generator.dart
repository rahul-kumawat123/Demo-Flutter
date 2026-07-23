import 'dart:math';

/// Generates cryptographically secure nonces for HMAC requests.
///
/// A nonce (number used once) prevents replay attacks within the timestamp
/// window — even if an attacker captures a valid request, re-sending it with
/// the same nonce can be detected and rejected by the server.
class NonceGenerator {
  const NonceGenerator();

  static const _chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

  /// Returns a random alphanumeric nonce of [length] characters.
  String generate({int length = 32}) {
    final random = Random.secure();
    return List.generate(
      length,
      (_) => _chars[random.nextInt(_chars.length)],
    ).join();
  }
}
