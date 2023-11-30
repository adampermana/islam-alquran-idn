import 'package:dio/dio.dart';

const baseUrl = '';

class DioHelper {
  static Dio init() {
    final options = BaseOptions(
      baseUrl: baseUrl,
      validateStatus: (status) => status != null ? status < 400 : false,
      connectTimeout: const Duration(minutes: 5),
      sendTimeout: const Duration(minutes: 5),
      receiveTimeout: const Duration(minutes: 5),
    );
    return Dio(options)..interceptors.addAll([LogInterceptor()]);
  }
}