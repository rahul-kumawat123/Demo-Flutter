import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../security/hmac_verifier.dart';
import '../data/demo_repository_impl.dart';
import '../domain/api_call_result.dart';
import '../domain/demo_repository.dart';
import 'hmac_demo_state.dart';

class HmacDemoCubit extends Cubit<HmacDemoState> {
  HmacDemoCubit({
    DemoRepository? repository,
    HmacVerifier? verifier,
  })  : _repository = repository ?? DemoRepositoryImpl(),
        _verifier = verifier ?? HmacVerifier(),
        super(const HmacDemoState());

  final DemoRepository _repository;
  final HmacVerifier _verifier;

  Future<void> getUsersPlain() => _run(
        (repo) => repo.getUsersPlain(),
        (result) => state.copyWith(lastPlainGetResult: result),
      );

  Future<void> postDataPlain() => _run(
        (repo) => repo.postDataPlain(),
        (result) => state.copyWith(lastPlainPostResult: result),
      );

  Future<void> getUsersHmac() => _run(
        (repo) => repo.getUsersHmac(),
        (result) => state.copyWith(lastHmacGetResult: result),
      );

  Future<void> postDataHmac() => _run(
        (repo) => repo.postDataHmac(),
        (result) => state.copyWith(lastHmacPostResult: result),
      );

  /// Demonstrates signature failure when the body is tampered after signing.
  Future<void> demonstrateTamperedBody() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final original = await _repository.postDataHmac();
    if (original.signature == null ||
        original.timestamp == null ||
        original.nonce == null) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Run POST Data (HMAC) first to get signing data',
      ));
      return;
    }

    final tamperedBody =
        '{"title":"Tampered","body":"Modified after signing","userId":99}';

    final verification = _verifier.verifyWithTamperedBody(
      method: 'POST',
      path: '/posts',
      timestamp: original.timestamp!,
      nonce: original.nonce!,
      receivedSignature: original.signature!,
      originalBody: original.requestBody ?? '',
      tamperedBody: tamperedBody,
    );

    final result = ApiCallResult(
      method: 'POST',
      url: original.url,
      requestHeaders: original.requestHeaders,
      requestBody: tamperedBody,
      responseBody: 'Simulated: body changed after signing',
      statusCode: null,
      elapsedMs: 0,
      isHmacSigned: true,
      timestamp: original.timestamp,
      nonce: original.nonce,
      canonicalString: original.canonicalString,
      signature: original.signature,
      verificationResult: verification,
    );

    emit(state.copyWith(isLoading: false, tamperBodyResult: result));
  }

  /// Demonstrates signature failure when the timestamp is changed.
  Future<void> demonstrateTamperedTimestamp() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final original = await _repository.getUsersHmac();
    if (original.signature == null ||
        original.timestamp == null ||
        original.nonce == null) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Run GET Users (HMAC) first to get signing data',
      ));
      return;
    }

    final tamperedTimestamp =
        (int.parse(original.timestamp!) - 600).toString();

    final verification = _verifier.verifyWithTamperedTimestamp(
      method: 'GET',
      path: '/users',
      originalTimestamp: original.timestamp!,
      tamperedTimestamp: tamperedTimestamp,
      nonce: original.nonce!,
      receivedSignature: original.signature!,
    );

    final result = ApiCallResult(
      method: 'GET',
      url: original.url,
      requestHeaders: original.requestHeaders,
      requestBody: null,
      responseBody: 'Simulated: timestamp changed from ${original.timestamp} to $tamperedTimestamp',
      statusCode: null,
      elapsedMs: 0,
      isHmacSigned: true,
      timestamp: tamperedTimestamp,
      nonce: original.nonce,
      canonicalString: original.canonicalString,
      signature: original.signature,
      verificationResult: verification,
    );

    emit(state.copyWith(isLoading: false, tamperTimestampResult: result));
  }

  /// Demonstrates signature failure when the server uses a wrong secret.
  Future<void> demonstrateWrongSecret() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final original = await _repository.getUsersHmac();
    if (original.signature == null ||
        original.timestamp == null ||
        original.nonce == null) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Run GET Users (HMAC) first to get signing data',
      ));
      return;
    }

    final verification = _verifier.verifyWithWrongSecret(
      method: 'GET',
      path: '/users',
      timestamp: original.timestamp!,
      nonce: original.nonce!,
      receivedSignature: original.signature!,
    );

    final result = ApiCallResult(
      method: 'GET',
      url: original.url,
      requestHeaders: original.requestHeaders,
      requestBody: null,
      responseBody: 'Simulated: server used a different secret key',
      statusCode: null,
      elapsedMs: 0,
      isHmacSigned: true,
      timestamp: original.timestamp,
      nonce: original.nonce,
      canonicalString: original.canonicalString,
      signature: original.signature,
      verificationResult: verification,
    );

    emit(state.copyWith(isLoading: false, tamperSecretResult: result));
  }

  Future<void> _run(
    Future<ApiCallResult> Function(DemoRepository) action,
    HmacDemoState Function(ApiCallResult) update,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final result = await action(_repository);
      emit(update(result).copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
