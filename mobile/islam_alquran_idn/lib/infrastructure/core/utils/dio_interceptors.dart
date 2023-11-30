import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show debugPrint;

import '../../../injector.dart';

// class RequestInterceptor extends Interceptor {
//   final IAuthLocalDatasource _authLocalDatasource = sl();

//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     final token = _authLocalDatasource.authData?.token;
//     if (token != null) {
//       options.headers['Authorization'] = 'Bearer $token';
//     }
//     return handler.next(options);
//   }
// }

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String headers = '';
    options.headers.forEach((key, value) {
      headers += '|    $key: $value\n';
    });

    debugPrint(
        '┌------------------------------------------------------------------------------');
    debugPrint('| [DIO] Request: ${options.method} ${options.uri} ');
    debugPrint('| Headers:\n$headers');
    if (options.queryParameters.isNotEmpty) {
      debugPrint('| Parameters:');
      options.queryParameters.forEach((key, value) {
        debugPrint('|    $key -> $value');
      });
    }
    if (options.data != null) {
      debugPrint('| Body:');
      if (options.data is Map) {
        (options.data as Map).forEach((key, value) {
          debugPrint('|    $key -> $value');
        });
      } else if (options.data is FormData) {
        for (var e in (options.data as FormData).fields) {
          debugPrint('|    ${e.key} -> ${e.value}');
        }
        for (var e in (options.data as FormData).files) {
          debugPrint('|    ${e.key} -> ${e.value}');
        }
      } else {
        debugPrint('|    ${options.data.toString()}');
      }
    }
    debugPrint(
        '├------------------------------------------------------------------------------');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        '| [DIO] Response ${response.requestOptions.uri} [code ${response.statusCode}]: ${response.data.toString()}');
    debugPrint(
        '└------------------------------------------------------------------------------');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint(
        '| [DIO] Error ${err.requestOptions.uri}: ${err.error}: ${err.response.toString()}');
    debugPrint(
        '└------------------------------------------------------------------------------');

    super.onError(err, handler);
  }
}
