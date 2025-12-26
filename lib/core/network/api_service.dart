import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'api_constants.dart';
import 'api_exceptions.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  late final Dio _dio;

  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Authorization': 'Bearer ${ApiConstants.bearerToken}',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add logging interceptor for debugging
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) => print('DIO: $object'),
      ),
    );
  }

  /// GET request with Either response
  Future<Either<ApiException, T>> get<T>({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return Right(fromJson(data));
      } else {
        return Left(
          ApiException(
            message: 'Unexpected error',
            statusCode: response.statusCode,
          ),
        );
      }
    } on DioException catch (e) {
      return Left(handleDioException(e));
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  /// POST request with Either response
  Future<Either<ApiException, T>> post<T>({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data as Map<String, dynamic>;
        return Right(fromJson(responseData));
      } else {
        return Left(
          ApiException(
            message: 'Unexpected error',
            statusCode: response.statusCode,
          ),
        );
      }
    } on DioException catch (e) {
      return Left(handleDioException(e));
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }
}

