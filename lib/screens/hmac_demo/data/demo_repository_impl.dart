import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../security/hmac_verifier.dart';
import '../../../security/interceptors/hmac_interceptor.dart';
import '../domain/api_call_result.dart';
import '../domain/demo_repository.dart';
import 'demo_api_client.dart';

class DemoRepositoryImpl implements DemoRepository {
  DemoRepositoryImpl({
    Dio? plainClient,
    Dio? hmacClient,
    HmacVerifier? verifier,
  })  : _plainClient = plainClient ?? DemoApiClient.createPlainClient(),
        _hmacClient = hmacClient ?? DemoApiClient.createHmacClient(),
        _verifier = verifier ?? HmacVerifier();

  final Dio _plainClient;
  final Dio _hmacClient;
  final HmacVerifier _verifier;

  static const _postBody = {
    'title': 'HMAC Demo Post',
    'body': 'This is a signed POST request demonstration.',
    'userId': 1,
  };

  @override
  Future<ApiCallResult> getUsersPlain() {
    return _executePlain(
      method: 'GET',
      endpoint: DemoApiConstants.usersEndpoint,
    );
  }

  @override
  Future<ApiCallResult> postDataPlain() {
    return _executePlain(
      method: 'POST',
      endpoint: DemoApiConstants.postsEndpoint,
      body: _postBody,
    );
  }

  @override
  Future<ApiCallResult> getUsersHmac() {
    return _executeHmac(
      method: 'GET',
      endpoint: DemoApiConstants.usersEndpoint,
    );
  }

  @override
  Future<ApiCallResult> postDataHmac() {
    return _executeHmac(
      method: 'POST',
      endpoint: DemoApiConstants.postsEndpoint,
      body: _postBody,
    );
  }

  Future<ApiCallResult> _executePlain({
    required String method,
    required String endpoint,
    Map<String, dynamic>? body,
  }) async {
    final stopwatch = Stopwatch()..start();

    try {
      final Response<dynamic> response;
      if (method == 'GET') {
        response = await _plainClient.get(endpoint);
      } else {
        response = await _plainClient.post(endpoint, data: body);
      }

      stopwatch.stop();

      return ApiCallResult(
        method: method,
        url: '${DemoApiConstants.baseUrl}$endpoint',
        requestHeaders: Map<String, dynamic>.from(response.requestOptions.headers),
        requestBody: body != null ? jsonEncode(body) : null,
        responseBody: _formatResponse(response.data),
        statusCode: response.statusCode,
        elapsedMs: stopwatch.elapsedMilliseconds,
        isHmacSigned: false,
      );
    } on DioException catch (e) {
      stopwatch.stop();
      return ApiCallResult(
        method: method,
        url: '${DemoApiConstants.baseUrl}$endpoint',
        requestHeaders: e.requestOptions.headers,
        requestBody: body != null ? jsonEncode(body) : null,
        responseBody: e.response?.data?.toString() ?? '',
        statusCode: e.response?.statusCode,
        elapsedMs: stopwatch.elapsedMilliseconds,
        isHmacSigned: false,
        errorMessage: e.message,
      );
    }
  }

  Future<ApiCallResult> _executeHmac({
    required String method,
    required String endpoint,
    Map<String, dynamic>? body,
  }) async {
    final stopwatch = Stopwatch()..start();

    try {
      final Response<dynamic> response;
      if (method == 'GET') {
        response = await _hmacClient.get(endpoint);
      } else {
        response = await _hmacClient.post(endpoint, data: body);
      }

      stopwatch.stop();

      final metadata = response.requestOptions.extra[HmacInterceptor.metadataKey]
          as HmacSigningMetadata?;

      VerificationResult? verification;
      if (metadata != null) {
        // Verify against the exact body the interceptor signed, so signing
        // and verification never diverge due to re-encoding differences.
        verification = _verifier.verify(
          method: method,
          path: endpoint,
          timestamp: metadata.timestamp,
          nonce: metadata.nonce,
          receivedSignature: metadata.signature,
          body: metadata.signedBody,
        );
      }

      return ApiCallResult(
        method: method,
        url: '${DemoApiConstants.baseUrl}$endpoint',
        requestHeaders: Map<String, dynamic>.from(response.requestOptions.headers),
        requestBody: _displayBody(metadata?.signedBody),
        responseBody: _formatResponse(response.data),
        statusCode: response.statusCode,
        elapsedMs: stopwatch.elapsedMilliseconds,
        isHmacSigned: true,
        timestamp: metadata?.timestamp,
        nonce: metadata?.nonce,
        canonicalString: metadata?.canonicalString,
        signature: metadata?.signature,
        verificationResult: verification,
      );
    } on DioException catch (e) {
      stopwatch.stop();

      final metadata = e.requestOptions.extra[HmacInterceptor.metadataKey]
          as HmacSigningMetadata?;

      return ApiCallResult(
        method: method,
        url: '${DemoApiConstants.baseUrl}$endpoint',
        requestHeaders: e.requestOptions.headers,
        requestBody: _displayBody(metadata?.signedBody),
        responseBody: e.response?.data?.toString() ?? '',
        statusCode: e.response?.statusCode,
        elapsedMs: stopwatch.elapsedMilliseconds,
        isHmacSigned: true,
        timestamp: metadata?.timestamp,
        nonce: metadata?.nonce,
        canonicalString: metadata?.canonicalString,
        signature: metadata?.signature,
        errorMessage: e.message,
      );
    }
  }

  String? _displayBody(String? signedBody) {
    if (signedBody == null || signedBody.isEmpty) return null;
    return signedBody;
  }

  String _formatResponse(dynamic data) {
    if (data == null) return '';
    if (data is String) return data;
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(data);
  }
}
