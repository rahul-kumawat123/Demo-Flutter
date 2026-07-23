import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/api_call_result.dart';

part 'hmac_demo_state.freezed.dart';

@freezed
class HmacDemoState with _$HmacDemoState {
  const factory HmacDemoState({
    @Default(false) bool isLoading,
    ApiCallResult? lastPlainGetResult,
    ApiCallResult? lastPlainPostResult,
    ApiCallResult? lastHmacGetResult,
    ApiCallResult? lastHmacPostResult,
    ApiCallResult? tamperBodyResult,
    ApiCallResult? tamperTimestampResult,
    ApiCallResult? tamperSecretResult,
    String? errorMessage,
  }) = _HmacDemoState;
}
