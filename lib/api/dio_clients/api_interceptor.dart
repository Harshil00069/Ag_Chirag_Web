import 'package:ag_chirag_web/utils/app_prefs_manager.dart';
import 'package:dio/dio.dart';


class ApiInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["Authorization"] = "Bearer ${SharedPref.getAccessToken}";
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.badResponse &&
        err.response?.statusCode == 401) {
      // await UserInfo.logOut();
      return handler.next(err);
    }
    return handler.next(err);
  }
}
