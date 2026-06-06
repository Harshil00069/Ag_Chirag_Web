// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:ag_chirag_web/constant/custom_http_exception.dart';
import 'package:ag_chirag_web/screens/module/Tabs/home_tab/model/account_data_model.dart';
import 'package:ag_chirag_web/screens/module/Tabs/home_tab/model/client_data_model.dart';
import 'package:ag_chirag_web/screens/module/Tabs/my_order_tab/model/order_book_data_model.dart';
import 'package:ag_chirag_web/screens/module/Tabs/position_data_tab/model/position_data_model.dart';
import 'package:ag_chirag_web/screens/module/Tabs/watch_list_tab/model/search_data_model.dart';
import 'package:ag_chirag_web/screens/module/Tabs/watch_list_tab/model/search_script_data_model.dart';
import 'package:ag_chirag_web/screens/module/Tabs/watch_list_tab/model/share_price_data_model.dart';
import 'package:flutter/foundation.dart';

import 'dio_client_base.dart';

class ApiImplementor {
  //----------------------------- new Code ------------------------------------------------------------------

  static Future<SearchScriptDataModel> loadScriptApiImplementer() async {
    try {
      final response = await DioClient.clientGet("Search_Script", body: {});
      if (response.statusCode == 200) {
        return SearchScriptDataModel.fromJson(response.data);
      } else {
        throw CustomHttpException(
          exceptionMsg: response.statusMessage.toString(),
        );
      }
    } catch (error) {
      logData(error);
      rethrow;
    }
  }

  static Future<SearchDataModel> searchScriptApiImplementer({
    required String type,
  }) async {
    try {
      final response = await DioClient.clientGet(
        "GetSegmentData/$type",
        body: {},
      );
      if (response.statusCode == 200) {
        return SearchDataModel.fromJson(response.data);
      } else {
        throw CustomHttpException(
          exceptionMsg: response.statusMessage.toString(),
        );
      }
    } catch (error) {
      logData(error);
      rethrow;
    }
  }

  static Future<ClientDataModel> userLoginApiImplementer({
    required List userList,
  }) async {
    try {
      final response = await DioClient.clientPost(
        "loginUser",
        body: {'userList': jsonEncode(userList)},
      );
      if (response.statusCode == 200) {
        return ClientDataModel.fromJson(response.data);
      } else {
        throw CustomHttpException(
          exceptionMsg: response.statusMessage.toString(),
        );
      }
    } catch (error) {
      logData(error);
      rethrow;
    }
  }

  static Future<AccountDataModel> userAccountDetailApiImplementer({
    required List userList,
  }) async {
    try {
      final response = await DioClient.clientPost(
        "getRMS",
        body: {'userList': jsonEncode(userList)},
      );
      if (response.statusCode == 200) {
        return AccountDataModel.fromJson(response.data);
      } else {
        throw CustomHttpException(
          exceptionMsg: response.statusMessage.toString(),
        );
      }
    } catch (error) {
      logData(error);
      rethrow;
    }
  }

  static Future<SharePriceDataModel> getLtpApiImplementer({
    required List userList,
    required List ltpList,
  }) async {
    try {
      final response = await DioClient.clientPost(
        "getLTP",
        body: {
          'userList': jsonEncode(userList),
          'ltpList': jsonEncode(ltpList),
        },
      );
      if (response.statusCode == 200) {
        return SharePriceDataModel.fromJson(response.data);
      } else {
        throw CustomHttpException(
          exceptionMsg: response.statusMessage.toString(),
        );
      }
    } catch (error) {
      logData(error);
      rethrow;
    }
  }

  static Future<OrderBookDataModel> getOrdersListApiImplementer({
    required List userList,
  }) async {
    try {
      final response = await DioClient.clientPost(
        "getOrderBook",
        body: {'userList': jsonEncode(userList)},
      );
      if (response.statusCode == 200) {
        return OrderBookDataModel.fromJson(response.data);
      } else {
        throw CustomHttpException(
          exceptionMsg: response.statusMessage.toString(),
        );
      }
    } catch (error) {
      logData(error);
      rethrow;
    }
  }

  static Future<SharePriceDataModel> cancelOrdersApiImplementer({
    required List userList,
    required List cancelOrderList,
  }) async {
    try {
      final response = await DioClient.clientPost(
        "getOrderCancel",
        body: {
          'userList': jsonEncode(userList),
          'cancelOrderList': jsonEncode(cancelOrderList),
        },
      );
      if (response.statusCode == 200) {
        return SharePriceDataModel.fromJson(response.data);
      } else {
        throw CustomHttpException(
          exceptionMsg: response.statusMessage.toString(),
        );
      }
    } catch (error) {
      logData(error);
      rethrow;
    }
  }

  static Future<PositionDataModel> getPositionApiImplementer({
    required List userList,
  }) async {
    try {
      final response = await DioClient.clientPost(
        "getPositionData",
        body: {'userList': jsonEncode(userList)},
      );
      // logData(response.realUri);
      // logData(response.data);
      if (response.statusCode == 200) {
        return PositionDataModel.fromJson(response.data);
      } else {
        throw CustomHttpException(
          exceptionMsg: response.statusMessage.toString(),
        );
      }
    } catch (error) {
      logData(error);
      rethrow;
    }
  }

  static Future<SharePriceDataModel> getOrderPlaceApiImplementer({
    required List userList,
    required List orderList,
  }) async {
    try {
      final response = await DioClient.clientPost(
        "getOrderPlace",
        body: {
          'userList': jsonEncode(userList),
          'placeOrderList': jsonEncode(orderList),
        },
      );
      if (response.statusCode == 200) {
        return SharePriceDataModel.fromJson(response.data);
      } else {
        throw CustomHttpException(
          exceptionMsg: response.statusMessage.toString(),
        );
      }
    } catch (error) {
      logData(error);
      rethrow;
    }
  }

  static Future<SharePriceDataModel> getModifyOrderPlaceApiImplementer({
    required List userList,
    required List orderList,
  }) async {
    try {
      final response = await DioClient.clientPost(
        "getOrderModify",
        body: {
          'userList': jsonEncode(userList),
          'modifyOrderList': jsonEncode(orderList),
        },
      );
      if (response.statusCode == 200) {
        return SharePriceDataModel.fromJson(response.data);
      } else {
        throw CustomHttpException(
          exceptionMsg: response.statusMessage.toString(),
        );
      }
    } catch (error) {
      logData(error);
      rethrow;
    }
  }

  /// Log debug Data
  static void logData(Object? object) {
    if (kDebugMode) {
      print(object);
    }
  }
}
