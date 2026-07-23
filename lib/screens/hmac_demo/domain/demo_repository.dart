import 'api_call_result.dart';

/// Contract for the four HMAC demo API calls.
abstract class DemoRepository {
  Future<ApiCallResult> getUsersPlain();
  Future<ApiCallResult> postDataPlain();
  Future<ApiCallResult> getUsersHmac();
  Future<ApiCallResult> postDataHmac();
}
