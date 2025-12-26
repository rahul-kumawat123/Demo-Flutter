import 'package:dio/dio.dart';

/// Base class for API errors
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => message;
}

/// Timeout error
class ApiTimeoutException extends ApiException {
  const ApiTimeoutException()
      : super(message: 'Connection timeout. Please try again.');
}

/// Server error (5xx)
class ServerException extends ApiException {
  const ServerException({String? message, int? statusCode})
      : super(
          message: message ?? 'Server error. Please try again later.',
          statusCode: statusCode,
        );
}

/// Network error (no internet)
class NetworkException extends ApiException {
  const NetworkException()
      : super(message: 'No internet connection. Please check your network.');
}

/// Unauthorized error (401)
class UnauthorizedException extends ApiException {
  const UnauthorizedException()
      : super(message: 'Unauthorized. Please login again.', statusCode: 401);
}

/// Not found error (404)
class NotFoundException extends ApiException {
  const NotFoundException()
      : super(message: 'Resource not found.', statusCode: 404);
}

/// Bad request error (400)
class BadRequestException extends ApiException {
  const BadRequestException({String? message})
      : super(message: message ?? 'Bad request.', statusCode: 400);
}

/// Parse DioException to ApiException
ApiException handleDioException(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return const ApiTimeoutException();

    case DioExceptionType.connectionError:
      return const NetworkException();

    case DioExceptionType.badResponse:
      final statusCode = error.response?.statusCode;
      final message = _extractErrorMessage(error.response?.data);

      if (statusCode == 401) {
        return const UnauthorizedException();
      } else if (statusCode == 404) {
        return const NotFoundException();
      } else if (statusCode == 400) {
        return BadRequestException(message: message);
      } else if (statusCode != null && statusCode >= 500) {
        return ServerException(message: message, statusCode: statusCode);
      }
      return ApiException(message: message ?? 'Unknown error', statusCode: statusCode);

    case DioExceptionType.cancel:
      return const ApiException(message: 'Request cancelled');

    default:
      return ApiException(message: error.message ?? 'Unknown error occurred');
  }
}

String? _extractErrorMessage(dynamic data) {
  if (data == null) return null;
  if (data is Map<String, dynamic>) {
    return data['status_message'] as String? ?? data['message'] as String?;
  }
  return data.toString();
}

