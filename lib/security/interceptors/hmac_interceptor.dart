import 'dart:convert';

import 'package:dio/dio.dart';

import '../request_signer.dart';

/// Metadata captured during HMAC signing for display in the UI.
class HmacSigningMetadata {
  const HmacSigningMetadata({
    required this.timestamp,
    required this.nonce,
    required this.signedBody,
    required this.canonicalString,
    required this.signature,
    required this.headers,
  });

  final String timestamp;
  final String nonce;

  /// The exact body string that was signed by the interceptor. Verification
  /// must reuse this value rather than re-encoding the original payload.
  final String signedBody;
  final String canonicalString;
  final String signature;
  final Map<String, String> headers;

  factory HmacSigningMetadata.fromSignedRequest(SignedRequest signed) {
    return HmacSigningMetadata(
      timestamp: signed.timestamp,
      nonce: signed.nonce,
      signedBody: signed.body,
      canonicalString: signed.canonicalString,
      signature: signed.signature,
      headers: signed.headers,
    );
  }
}

/// Dio interceptor that automatically signs outgoing requests with HMAC.
///
/// On every request it:
/// 1. Extracts method, path, and body.
/// 2. Delegates to [RequestSigner] for timestamp, nonce, canonical string, signature.
/// 3. Attaches HMAC headers to the request.
/// 4. Stores signing metadata in [RequestOptions.extra] for the UI layer.
class HmacInterceptor extends Interceptor {
  HmacInterceptor({RequestSigner? requestSigner})
      : _requestSigner = requestSigner ?? RequestSigner();

  final RequestSigner _requestSigner;

  static const String metadataKey = 'hmac_signing_metadata';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final method = options.method;
    final path = _buildPath(options);
    final body = _extractBody(options);

    final signed = _requestSigner.sign(
      method: method,
      path: path,
      body: body,
    );

    options.headers.addAll(signed.headers);

    options.extra[metadataKey] = HmacSigningMetadata.fromSignedRequest(signed);

    handler.next(options);
  }

  String _buildPath(RequestOptions options) {
    final uri = options.uri;
    final path = uri.path;
    if (uri.query.isNotEmpty) {
      return '$path?${uri.query}';
    }
    return path;
  }

  String _extractBody(RequestOptions options) {
    final data = options.data;
    if (data == null) return '';
    if (data is String) return data;
    if (data is Map || data is List) {
      return jsonEncode(data);
    }
    return data.toString();
  }
}
