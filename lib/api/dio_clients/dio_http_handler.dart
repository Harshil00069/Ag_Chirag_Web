import 'package:dio/dio.dart';

class DioExceptionHandler {
  static String handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timeout. Please try again.";
      case DioExceptionType.sendTimeout:
        return "Request send timeout. Please try again.";
      case DioExceptionType.receiveTimeout:
        return "Response timeout. Please try again.";
      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);
      case DioExceptionType.cancel:
        return "Request was cancelled.";
      case DioExceptionType.connectionError:
        return "No internet connection. Please check your network.";
      case DioExceptionType.unknown:
        return "Something went wrong. Please try again.";
      default:
        return "Unexpected error occurred.";
    }
  }

  static String _handleBadResponse(Response? response) {
    if (response == null) {
      return "No response from server.";
    }

    switch (response.statusCode) {
      case 401:
        return "Unauthorized. Please login again.";
      case 400:
        return "Bad request. Please check your input.";
      case 403:
        return "Forbidden. You don't have permission to access this.";
      case 404:
        return "Not found. The requested resource doesn't exist.";
      case 500:
        return "Server error. Please try again later.";
      case 502:
        return "Bad gateway. Server is down.";
      case 503:
        return "Service unavailable. Please try again later.";
      default:
        return "Unexpected error: ${response.statusMessage}";
    }
  }
}
