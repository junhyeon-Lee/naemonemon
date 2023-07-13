import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shovving_pre/util/safe_print.dart';

class CacheManager {
  static Future getJson({required String key}) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    dynamic cache = sharedPreferences.getString(key);
    var jsonMapCache = jsonDecode(cache??"") as Map<dynamic, dynamic>;
    return jsonMapCache;
  }

  static Future deleteKey(String key, [dynamic takeAction]) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key).whenComplete(() => takeAction);
  }

  static Future setJson(
      {required String key, required Map<dynamic, dynamic> value}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    var jsonMap = value;
    await sharedPreferences.setString(key, jsonEncode(jsonMap));
  }
}
