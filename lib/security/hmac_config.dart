/// HMAC configuration for the API security POC.
///
/// ⚠️ SECURITY WARNING — FOR DEMO / LEARNING ONLY
/// Hardcoding a shared secret in a mobile app is insecure. Anyone who
/// decompiles or inspects the APK/IPA can extract this value and forge
/// valid signatures. In production, use per-user or per-device keys issued
/// by the server, certificate pinning, and additional attestation layers.
class HmacConfig {
  HmacConfig._();

  /// Shared secret used to sign requests (demo only — never ship this way).
  static const String secretKey = 'demo-hmac-secret-key-poc-2026';

  /// Algorithm identifier sent in the Authorization header.
  static const String algorithm = 'HMAC-SHA256';

  /// Maximum age of a request timestamp before the verifier rejects it.
  static const Duration maxTimestampAge = Duration(minutes: 5);

  // Header names
  static const String authorizationHeader = 'Authorization';
  static const String timestampHeader = 'X-Timestamp';
  static const String nonceHeader = 'X-Nonce';
  static const String signatureHeader = 'X-Signature';

  /// Builds the Authorization header value, e.g. "HMAC-SHA256 Credential=demo-client".
  static String authorizationValue({String credential = 'demo-client'}) {
    return '$algorithm Credential=$credential';
  }
}
