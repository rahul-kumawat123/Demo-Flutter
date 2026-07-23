import '../../../security/hmac_verifier.dart';

/// Immutable result of a single API call in the HMAC demo.
class ApiCallResult {
  const ApiCallResult({
    required this.method,
    required this.url,
    required this.requestHeaders,
    required this.requestBody,
    required this.responseBody,
    required this.statusCode,
    required this.elapsedMs,
    required this.isHmacSigned,
    this.timestamp,
    this.nonce,
    this.canonicalString,
    this.signature,
    this.verificationResult,
    this.errorMessage,
  });

  final String method;
  final String url;
  final Map<String, dynamic> requestHeaders;
  final String? requestBody;
  final String responseBody;
  final int? statusCode;
  final int elapsedMs;
  final bool isHmacSigned;

  // HMAC-specific fields
  final String? timestamp;
  final String? nonce;
  final String? canonicalString;
  final String? signature;
  final VerificationResult? verificationResult;
  final String? errorMessage;

  bool get isSuccess =>
      statusCode != null && statusCode! >= 200 && statusCode! < 300;

  bool get hasVerification => verificationResult != null;
}
