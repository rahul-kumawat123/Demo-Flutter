import 'hmac_config.dart';
import 'nonce_generator.dart';
import 'signature_generator.dart';

/// Result of signing an HTTP request.
class SignedRequest {
  const SignedRequest({
    required this.timestamp,
    required this.nonce,
    required this.body,
    required this.canonicalString,
    required this.signature,
    required this.headers,
  });

  final String timestamp;
  final String nonce;

  /// The exact body string that was signed. Verification must use this same
  /// value to avoid signature mismatches from re-encoding differences.
  final String body;
  final String canonicalString;
  final String signature;
  final Map<String, String> headers;
}

/// Orchestrates the full request-signing flow.
///
/// 1. Generate a Unix timestamp (replay window enforcement on server).
/// 2. Generate a cryptographically random nonce (replay uniqueness).
/// 3. Build the canonical string from method, path, timestamp, nonce, body hash.
/// 4. Compute HMAC-SHA256 signature.
/// 5. Attach all required headers.
class RequestSigner {
  RequestSigner({
    SignatureGenerator? signatureGenerator,
    NonceGenerator? nonceGenerator,
    String? secretKey,
  })  : _signatureGenerator =
            signatureGenerator ?? const SignatureGenerator(),
        _nonceGenerator = nonceGenerator ?? const NonceGenerator(),
        _secretKey = secretKey ?? HmacConfig.secretKey;

  final SignatureGenerator _signatureGenerator;
  final NonceGenerator _nonceGenerator;
  final String _secretKey;

  /// Signs [method] [path] with optional [body] and returns signing metadata.
  SignedRequest sign({
    required String method,
    required String path,
    String body = '',
  }) {
    final timestamp =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    final nonce = _nonceGenerator.generate();

    final canonicalString = _signatureGenerator.buildCanonicalString(
      method: method.toUpperCase(),
      path: path,
      timestamp: timestamp,
      nonce: nonce,
      body: body,
    );

    final signature = _signatureGenerator.sign(
      canonicalString: canonicalString,
      secretKey: _secretKey,
    );

    final headers = <String, String>{
      HmacConfig.authorizationHeader: HmacConfig.authorizationValue(),
      HmacConfig.timestampHeader: timestamp,
      HmacConfig.nonceHeader: nonce,
      HmacConfig.signatureHeader: signature,
    };

    return SignedRequest(
      timestamp: timestamp,
      nonce: nonce,
      body: body,
      canonicalString: canonicalString,
      signature: signature,
      headers: headers,
    );
  }
}
