import 'dart:convert';
import 'dart:io';import 'package:ag_chirag_web/api/api_logger_interceptor.dart';
import 'package:ag_chirag_web/api/api_urls.dart';
import 'package:ag_chirag_web/constant/custom_http_exception.dart';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';

class DioClient {
  static Dio? dio;

  static Dio? getDioClient({int delay = 20000}) {
    if (dio == null) {
      dio = Dio();
      dio!.options.baseUrl = ApiUrls.baseUrl;
      // dio!.interceptors.add(ApiTokenAdapter());
      dio!.options.connectTimeout = Duration(milliseconds: delay);
      dio!.options.receiveTimeout = Duration(milliseconds: delay);
      if (ApiUrls.isApiLoggerEnabled) {
        dio!.interceptors.add(ApiLoggerInterceptor());
      }
    }
    return dio;
  }

  static void commonDebugLogger(dynamic val) {
    if (kDebugMode) {
      debugPrint("$val");
    }
  }

  static Future<dynamic> clientPost(String apiName,
      {required Map<String, String> body,
      Map<String, String>? customHeaders,
      int delaytTime = 20000,
      bool inParams = true}) async {
    commonDebugLogger("Client Post $apiName And Bodty $body");

    try {
      final response = await getDioClient(delay: delaytTime)!
          .post(apiName,
              queryParameters: inParams ? body : null,
              data: inParams ? null : body,
              options: Options(
                  headers: customHeaders ?? {'content-type': 'text/plain'}))
          .onError((error, stackTrace) {
        commonDebugLogger("error POST $apiName");
        commonDebugLogger(error.toString());
        throw CustomHttpException.handleDioError(
            dioError: error as DioException);
      });
      commonDebugLogger("${response.realUri}\n ${response.statusCode}");
      if (response.statusCode == 200) {
        DioClient.commonDebugLogger(
            "in post api $apiName Body: $body And Response ${response.data}");

        return response.data != null ? jsonDecode(response.data) : null;
      } else {
        commonDebugLogger(response.statusMessage.toString());
        throw DioException(
            requestOptions: response.requestOptions,
            error: response.statusMessage);
      }
    } on DioException catch (dioError) {
      String errMsg = CustomHttpException.handleDioError(dioError: dioError);
      throw errMsg;
    } catch (error) {
      String errMsg = CustomHttpException.handleDioError(
          dioError:
              DioException(requestOptions: RequestOptions(), error: error));
      throw errMsg;
    }
  }

  static Future clientGet(String apiName,
      {required Map<String, String> body, int delaytTime = 20000}) async {
    commonDebugLogger("Client Get $apiName \nBody $body");

    try {
      final response = await getDioClient(delay: delaytTime)!
          .get(apiName,
              queryParameters: body,
              options: Options(headers: {'content-type': 'text/plain'}))
          .onError((error, stackTrace) {
        commonDebugLogger("error Get $apiName");
        commonDebugLogger(error.toString());
        throw CustomHttpException.handleDioError(
            dioError: error as DioException);
      });
      commonDebugLogger("${response.realUri}\n ${response.statusCode}");
      //commonDebugLogger("Data: ${response.data}");
      // commonDebugLogger("Data: ${response.statusCode}");
      // commonDebugLogger("Data: ${response.runtimeType}");
      // commonDebugLogger("Data: ${response.data is String}");

      if (response.statusCode == 200) {
        return response.data != null ? jsonDecode(response.data) : null;
      } else {
        throw DioException(
            requestOptions: response.requestOptions,
            error: response.statusMessage);
      }
    } on DioException catch (dioError) {
      String errMsg = CustomHttpException.handleDioError(dioError: dioError);
      throw errMsg;
    } catch (error) {
      String errMsg = CustomHttpException.handleDioError(
          dioError:
              DioException(requestOptions: RequestOptions(), error: error));
      throw errMsg;
    }
  }

  static Future clientMultiPart(String apiName,
      {required Map<String, String> body,
      int delaytTime = 20000,
      File? file}) async {
    DioClient.commonDebugLogger("clientMultiPart $apiName \nBody $body");
    late Response<dynamic> response;
    try {
      if (file != null) {
        String fileName = file.path.split('/').last;
        var fileExt = fileName.split('.').last;
        var formData = FormData.fromMap({
          'image': await MultipartFile.fromFile(
            file.path,
            filename: fileName,
            contentType: MediaType("image", fileExt),
          ),
        });
        response = await getDioClient(delay: delaytTime)!
            .post(apiName,
                queryParameters: body,
                data: formData,
                options: Options(
                    headers: {'content-type': 'text/plain'})) //badlalvvi
            .onError((error, stackTrace) {
          DioClient.commonDebugLogger(error.toString());
          throw CustomHttpException.handleDioError(
              dioError: error as DioException);
        });
      } else {
        var formData = FormData.fromMap({'image': ''});
        response = await getDioClient(delay: delaytTime)!
            .post(apiName,
                queryParameters: body,
                data: formData,
                options: Options(headers: {'content-type': 'text/plain'}))
            .onError((error, stackTrace) {
          if (kDebugMode) {
            DioClient.commonDebugLogger(error.toString());
          }
          throw CustomHttpException.handleDioError(
              dioError: error as DioException);
        });
      }
      DioClient.commonDebugLogger(
          "${response.realUri}\n ${response.statusCode}");
      if (response.statusCode == 200) {
        return response.data != null ? jsonDecode(response.data) : null;
      } else {
        DioClient.commonDebugLogger(response.statusMessage.toString());
        throw DioException(
            requestOptions: response.requestOptions,
            error: response.statusMessage);
      }
    } on DioException catch (dioError) {
      String errMsg = CustomHttpException.handleDioError(dioError: dioError);
      throw errMsg;
    } catch (error) {
      String errMsg = CustomHttpException.handleDioError(
          dioError:
              DioException(requestOptions: RequestOptions(), error: error));
      throw errMsg;
    }
  }

  static List isListAndNotEmpty(dynamic data) {
    return data != null
        ? data is List
            ? data.isNotEmpty
                ? data
                : []
            : []
        : [];
  }
}
