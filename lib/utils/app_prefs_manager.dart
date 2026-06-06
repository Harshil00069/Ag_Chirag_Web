import 'dart:convert';

import 'package:ag_chirag_web/screens/module/Tabs/home_tab/model/user_model.dart';
import 'package:ag_chirag_web/screens/module/Tabs/watch_list_tab/model/watch_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences _sharedPreferences;

  static String myUserList = "myUserList";
  static String myWatchList = "myWatchList";

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return;
  }

  static Future<bool> save(String key, dynamic value) async {
    var val = json.encode(value);
    return _sharedPreferences.setString(key, val);
  }

  static Future<void> setUserData(List<String> userModelList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList(myUserList, userModelList);
  }


  static Future<List<UserModel>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<UserModel> userList = [];
    List<String>? lst = prefs.getStringList(myUserList);

    if (lst != null) {
      for (var item in lst) {
        UserModel userModel = UserModel.fromJson(json.decode(item));
        userList.add(userModel);
      }
    }
    return userList;
  }

  static Future<void> setWatchData(List<String> watchModelList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList(myWatchList, watchModelList);
  }


  static Future<List<WatchListModel>> getWatchListData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<WatchListModel> watchList = [];
    List<String>? lst = prefs.getStringList(myWatchList);

    if (lst != null) {
      for (var item in lst) {
        WatchListModel watchListModel = WatchListModel.fromJson(json.decode(item));
        watchList.add(watchListModel);
      }
    }
    return watchList;
  }

  // static bool get isLogin =>
  //     _sharedPreferences.containsKey(ApiUrls.loginUser);
  //
  // static dynamic read(String key) {
  //   var data = _sharedPreferences.getString(key);
  //   var res = data != null ? json.decode(data) : null;
  //   return res;
  // }
  //
  // static String get getAccessToken =>
  //     _sharedPreferences.getString(ApiUrls.accessToken) ?? "";
  //
  // static Future<bool> setAccessToken({required String name}) async =>
  //     _sharedPreferences.setString(ApiUrls.accessToken, name);
}