import 'dart:convert';
import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:motion_toast/motion_toast.dart';

enum ToastType { success, info, error, warning }

class CommonUtils {
  static String getMonthNameByNumber(int month, {bool isFullName = false}) {
    switch (month) {
      case 1:
        return isFullName ? "January" : "Jan";
      case 2:
        return isFullName ? "February" : "Feb";
      case 3:
        return isFullName ? "March" : "Mar";
      case 4:
        return isFullName ? "April" : "Apr";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return isFullName ? "August" : "Aug";
      case 9:
        return isFullName ? "Septmber" : "Sep";
      case 10:
        return isFullName ? "October" : "Oct";
      case 11:
        return isFullName ? "November" : "Nov";
      case 12:
        return isFullName ? "December" : "Dec";
    }

    return '';
  }

  static String getDayNameByNumber(int day) {
    switch (day) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
    }

    return '';
  }

  static bool isWebLink(String input) {
    RegExp urlPattern = RegExp(
      r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$',
      caseSensitive: false,
    );
    return urlPattern.hasMatch(input);
  }

  /*  static Future<bool> isPermissionGranted() async {
    PermissionStatus storagePermissionStatus = await Permission.storage.status;
    if (storagePermissionStatus.isGranted) {
      return true;
    } else if (storagePermissionStatus.isDenied) {
      if (await Permission.storage.request().isGranted) {
        return true;
      }
    }
    return false;
  }

  static Future<void> openFileFromBase64String(
      {required String base64String, required String fileName}) async {
    try {
      Uint8List bytes = base64.decode(base64String);
      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = File('$dir/$fileName.pdf');
      File fileNew = await file.writeAsBytes(bytes);
      String filePath = fileNew.path;
      OpenFilex.open(filePath);
    } catch (e) {
      return;
    }
  }*/

  static void logMessage(Object message) {
    if (kDebugMode) {
      developer.log(message.toString());
    }
  }

  static void logErrorMessage(Object message) {
    if (kDebugMode) {
      developer.log('', name: "Error", error: message);
    }
  }

  static String generateCurl(RequestOptions options) {
    try {
      final method = options.method.toUpperCase();
      final uri = options.uri.toString();

      StringBuffer curl = StringBuffer(
        "curl --location --request $method '$uri' \\\n",
      );

      // -----------------------------
      // HEADERS
      // -----------------------------
      options.headers.forEach((k, v) {
        curl.write("--header '$k: $v' \\\n");
      });

      // -----------------------------
      // HANDLE GET (NO BODY)
      // -----------------------------
      if (method == "GET") {
        return curl.toString();
      }

      final data = options.data;

      // -----------------------------
      // x-www-form-urlencoded
      // -----------------------------
      if (options.headers["Content-Type"] ==
              "application/x-www-form-urlencoded" ||
          options.headers["content-type"] ==
              "application/x-www-form-urlencoded") {
        if (data is Map) {
          final encoded = data.entries
              .map(
                (e) =>
                    "${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value.toString())}",
              )
              .join("&");

          curl.write("--data '$encoded' \\\n");
        }

        return curl.toString();
      }

      // -----------------------------
      // FormData (files + fields)
      // -----------------------------
      if (data is FormData) {
        // fields
        for (var field in data.fields) {
          curl.write("--form '${field.key}=${field.value}' \\\n");
        }

        // files
        for (var file in data.files) {
          curl.write("--form '${file.key}=@\"${file.value.filename}\"' \\\n");
        }

        return curl.toString();
      }

      // -----------------------------
      // Default JSON body
      // -----------------------------
      if (data != null) {
        curl.write("--data '${jsonEncode(data)}' \\\n");
      }

      return curl.toString();
    } catch (e) {
      return "Error generating cURL: $e";
    }
  }
}
