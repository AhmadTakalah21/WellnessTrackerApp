import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:wellnesstrackerapp/features/auth_manager/bloc/auth_manager_bloc.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/dio/exceptions.dart';
import 'package:wellnesstrackerapp/global/services/user_repo.dart';
import 'package:wellnesstrackerapp/global/utils/logger.dart';

class AppInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Accept'] = 'application/json';
    
    final userRepo = get<UserRepo>();
    if (userRepo.isSignedIn) {
      options.headers['Authorization'] = 'Bearer ${userRepo.user?.token}';
      debugPrint('Bearer ${userRepo.user?.token}');
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.f(
      'Message: ${err.message}\n'
      'Error${err.error}\n'
      'Status code: ${err.response?.statusCode}\n'
      'Type: ${err.type}\n'
      'Response: ${err.response?.data}',
    );
    if (err.response?.statusCode == 401) {
      get<AuthManagerBloc>().add(SignOutRequested());
      throw UnauthorizedException(err.requestOptions);
    }
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      throw DeadlineExceededException(err.requestOptions);
    }
    throw CustomDioException(
      response: err.response,
      requestOptions: err.requestOptions,
    );
  }
}