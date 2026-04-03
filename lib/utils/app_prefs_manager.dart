import 'dart:convert';
import 'package:ag_chirag_web/api/api_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return;
  }

  static Future<bool> save(String key, dynamic value) async {
    var val = json.encode(value);
    return _sharedPreferences.setString(key, val);
  }

  static bool get isLogin =>
      _sharedPreferences.containsKey(ApiUrls.loginUser);

  static dynamic read(String key) {
    var data = _sharedPreferences.getString(key);
    var res = data != null ? json.decode(data) : null;
    return res;
  }

  static String get getAccessToken =>
      _sharedPreferences.getString(ApiUrls.accessToken) ?? "";

  static Future<bool> setAccessToken({required String name}) async =>
      _sharedPreferences.setString(ApiUrls.accessToken, name);
}