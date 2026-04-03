import 'package:ag_chirag_web/api/api_logger_interceptor.dart';
import 'package:ag_chirag_web/api/api_urls.dart';
import 'package:dio/dio.dart';
import 'api_interceptor.dart';

class TokenDioClient {
  static Dio? _dio;
  static ApiInterceptor? _apiInterceptor;

  static Dio? getTokenDioClient() {
    if (_dio == null) {
      _dio = Dio();
      _apiInterceptor = ApiInterceptor();
      _dio!.options.baseUrl = ApiUrls.baseUrl;
      _dio!.interceptors.add(_apiInterceptor!);
      _dio!.options.connectTimeout = const Duration(milliseconds: 200000);
      _dio!.options.receiveTimeout = const Duration(milliseconds: 200000);
      _dio!.interceptors.add(ApiLoggerInterceptor());
    /*  if (AppConfig().enableApiLogging) {
        _dio!.interceptors.add(ApiLoggerInterceptor());
      }*/
    }

    return _dio;
  }
}
