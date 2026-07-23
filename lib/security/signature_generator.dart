import 'hmac_service.dart';

/// Builds the canonical signing string and produces the HMAC signature.
///
/// Both client (signer) and server (verifier) must use the exact same
/// canonical format so signatures are reproducible and comparable.
///
/// Canonical string format:
/// ```
/// METHOD\n
/// path?query\n
/// timestamp\n
/// nonce\n
/// sha256(body)
/// ```
class SignatureGenerator {
  const SignatureGenerator({HmacService? hmacService})
      : _hmacService = hmacService ?? const HmacService();

  final HmacService _hmacService;

  /// Builds the canonical string used for signing.
  String buildCanonicalString({
    required String method,
    required String path,
    required String timestamp,
    required String nonce,
    String body = '',
  }) {
    final bodyHash = _hmacService.sha256Hex(body);
    return '$method\n$path\n$timestamp\n$nonce\n$bodyHash';
  }

  /// Signs [canonicalString] with [secretKey] and returns the hex signature.
  String sign({required String canonicalString, required String secretKey}) {
    return _hmacService.computeHmacHex(
      message: canonicalString,
      secretKey: secretKey,
    );
  }
}
