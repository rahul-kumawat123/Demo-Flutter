import 'hmac_config.dart';
import 'signature_generator.dart';

/// Outcome of verifying an HMAC signature (simulated backend).
enum VerificationStatus { valid, invalid }

/// Result returned by [HmacVerifier].
class VerificationResult {
  const VerificationResult({
    required this.status,
    required this.message,
    this.recomputedSignature,
    this.expectedSignature,
  });

  final VerificationStatus status;
  final String message;
  final String? recomputedSignature;
  final String? expectedSignature;

  bool get isValid => status == VerificationStatus.valid;
}

/// Simulates backend HMAC verification.
///
/// Recreates the canonical string from the received headers and body,
/// recomputes the signature, and compares using a constant-time approach.
/// Also supports tamper scenarios for educational demonstrations.
class HmacVerifier {
  HmacVerifier({
    SignatureGenerator? signatureGenerator,
    String? secretKey,
    Duration? maxTimestampAge,
  })  : _signatureGenerator =
            signatureGenerator ?? const SignatureGenerator(),
        _secretKey = secretKey ?? HmacConfig.secretKey,
        _maxTimestampAge = maxTimestampAge ?? HmacConfig.maxTimestampAge;

  final SignatureGenerator _signatureGenerator;
  final String _secretKey;
  final Duration _maxTimestampAge;

  /// Verifies the HMAC signature on an incoming request.
  VerificationResult verify({
    required String method,
    required String path,
    required String timestamp,
    required String nonce,
    required String receivedSignature,
    String body = '',
    String? secretKeyOverride,
  }) {
    // 1. Validate timestamp freshness
    final timestampSeconds = int.tryParse(timestamp);
    if (timestampSeconds == null) {
      return const VerificationResult(
        status: VerificationStatus.invalid,
        message: 'Invalid timestamp format',
      );
    }

    final requestTime =
        DateTime.fromMillisecondsSinceEpoch(timestampSeconds * 1000);
    final age = DateTime.now().difference(requestTime).abs();
    if (age > _maxTimestampAge) {
      return VerificationResult(
        status: VerificationStatus.invalid,
        message:
            'Timestamp expired (age: ${age.inSeconds}s, max: ${_maxTimestampAge.inSeconds}s)',
      );
    }

    // 2. Rebuild canonical string
    final canonicalString = _signatureGenerator.buildCanonicalString(
      method: method.toUpperCase(),
      path: path,
      timestamp: timestamp,
      nonce: nonce,
      body: body,
    );

    // 3. Recompute signature
    final secret = secretKeyOverride ?? _secretKey;
    final recomputed = _signatureGenerator.sign(
      canonicalString: canonicalString,
      secretKey: secret,
    );

    // 4. Constant-time comparison
    if (_constantTimeEquals(recomputed, receivedSignature)) {
      return VerificationResult(
        status: VerificationStatus.valid,
        message: 'Signature is valid',
        recomputedSignature: recomputed,
        expectedSignature: receivedSignature,
      );
    }

    return VerificationResult(
      status: VerificationStatus.invalid,
      message: 'Signature mismatch',
      recomputedSignature: recomputed,
      expectedSignature: receivedSignature,
    );
  }

  /// Demonstrates what happens when the request body is tampered with.
  VerificationResult verifyWithTamperedBody({
    required String method,
    required String path,
    required String timestamp,
    required String nonce,
    required String receivedSignature,
    required String originalBody,
    required String tamperedBody,
  }) {
    final result = verify(
      method: method,
      path: path,
      timestamp: timestamp,
      nonce: nonce,
      receivedSignature: receivedSignature,
      body: tamperedBody,
    );

    if (result.isValid) {
      return result;
    }

    return VerificationResult(
      status: VerificationStatus.invalid,
      message:
          'Body tampered: original hash differs from tampered body hash',
      recomputedSignature: result.recomputedSignature,
      expectedSignature: receivedSignature,
    );
  }

  /// Demonstrates what happens when the timestamp is changed after signing.
  VerificationResult verifyWithTamperedTimestamp({
    required String method,
    required String path,
    required String originalTimestamp,
    required String tamperedTimestamp,
    required String nonce,
    required String receivedSignature,
    String body = '',
  }) {
    return verify(
      method: method,
      path: path,
      timestamp: tamperedTimestamp,
      nonce: nonce,
      receivedSignature: receivedSignature,
      body: body,
    );
  }

  /// Demonstrates what happens when the server uses a different secret.
  VerificationResult verifyWithWrongSecret({
    required String method,
    required String path,
    required String timestamp,
    required String nonce,
    required String receivedSignature,
    String body = '',
    String wrongSecret = 'wrong-secret-key',
  }) {
    return verify(
      method: method,
      path: path,
      timestamp: timestamp,
      nonce: nonce,
      receivedSignature: receivedSignature,
      body: body,
      secretKeyOverride: wrongSecret,
    );
  }

  /// XOR-based constant-time string comparison to prevent timing attacks.
  bool _constantTimeEquals(String a, String b) {
    if (a.length != b.length) return false;
    var result = 0;
    for (var i = 0; i < a.length; i++) {
      result |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    return result == 0;
  }
}
