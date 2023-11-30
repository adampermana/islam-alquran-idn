import 'dart:io';

import 'package:dio/dio.dart' hide Headers;

class CacheException implements Exception {}

const int defaultErrorCode = -1;
const int socketErrorCode = -4;

class ServerException implements Exception {
  final int errorCode;
  final String errorMessage;
  final String errorTitle;
  final String erremail;

  const ServerException._(
      {this.errorCode = defaultErrorCode,
      required this.errorMessage,
      required this.errorTitle,
      required this.erremail});

  factory ServerException.withMessage(
      {required String title,
      required String message,
      int? statusCode,
      String? email}) {
    return ServerException._(
        errorCode: statusCode ?? defaultErrorCode,
        errorMessage: message,
        errorTitle: title,
        erremail: email ?? '');
  }

  factory ServerException.withError(DioException error) {
    return _handleError(error);
  }

  static ServerException _handleError(DioException error) {
    int code = defaultErrorCode;
    String message = '';
    String title = '';
    String email = '';

    switch (error.type) {
      case DioExceptionType.cancel:
        title = 'Oh no...';
        message = 'Request was cancelled';
        break;
      case DioExceptionType.connectionTimeout:
        title = 'Connection timeout...';
        message = 'Please check your internet connection and try again.';
        break;
      case DioExceptionType.unknown:
        final List<int> noNetworkConnectionCodes = [7, 101, 111];
        final exception = error.error;
        if (exception is SocketException &&
            noNetworkConnectionCodes.contains(exception.osError?.errorCode)) {
          code = socketErrorCode;
          title = 'No connection found';
          message = 'Please check your internet connection and try again.';
          break;
        }
        title = 'Oh no...';
        message = 'Internal Server Error';
        break;
      case DioExceptionType.receiveTimeout:
        title = 'Oh no...';
        message = 'Receive timeout in connection';
        break;
      case DioExceptionType.badResponse:
        code = error.response?.statusCode ?? -1;

        if (error.response?.data != null) {
          var data = error.response?.data['result'] ?? error.response?.data;

          if (data is String) {
            title = 'Oh no...';
            message = 'Something went wrong. We are working on it.';

            break;
          }

          if (data['message'].toString().contains('expired')) {
            code = 498;
            title = 'Unauthorized User';
            message = data['message'] ??
                'Your session is ended. Please login again to use this App.';
            break;
          }

          if (code == 401) {
            title = 'Unauthorized User';
            message = data['message'] ??
                'Token seems has been invalid or expired. Please re-login to use this App.';
            break;
          }

          if (code == 500) {
            title = 'Oh no...';
            message = 'Internal Server Error';
            if (data['message'] is String) {
              message = data["message"];
            }
            break;
          }

          title = 'Something went wrong';
          message =
              data['message'] ?? 'Something went wrong. We are working on it.';
          email = data['email'] ?? '';
          break;
        }
        title = 'Something went wrong';
        message = ((error.error is Map?)
                ? (error.error as Map)['message'] as String?
                : null) ??
            'Try refreshing the app';
        break;
      case DioExceptionType.sendTimeout:
        title = 'Oh no...';
        message = 'Receive timeout in send request';
        break;
      case DioExceptionType.badCertificate:
        title = 'This connection is not safe';
        message = 'Please ensure that you are going to correct site';
        break;
      case DioExceptionType.connectionError:
        title = 'Connection error...';
        message = 'Please check your internet connection and try again.';
        break;
    }

    return ServerException._(
        errorCode: code,
        errorMessage: message,
        errorTitle: title,
        erremail: email);
  }
}
