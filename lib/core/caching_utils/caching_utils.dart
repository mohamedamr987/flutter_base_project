import 'dart:convert';
import 'package:base_project/core/models/user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CachingUtils {
  static const String _cachingUserKey = 'logged_user';
  static const String _cachingTokenKey = 'token';

  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static User? get user {
    if (sharedPreferences.containsKey(_cachingUserKey)) {
      return User.fromJson(
        jsonDecode(
          sharedPreferences.getString(_cachingUserKey)!,
        ),
      );
    }
    return null;
  }

  static Future<void> cacheUser(Map<String, dynamic> value) async {
    await sharedPreferences.setString(_cachingUserKey, jsonEncode(value));
  }

  static Future<void> cacheToken(String value) async {
    await sharedPreferences.setString(_cachingTokenKey, value);
  }

  static Future<void> clearCache() async {
    try {
      FirebaseMessaging.instance.unsubscribeFromTopic("admin");
    } catch (e) {
      print(e);
    }
    await sharedPreferences.remove(_cachingUserKey);
    await sharedPreferences.remove(_cachingTokenKey);
  }

  static String? get token {
    return sharedPreferences.getString(_cachingTokenKey);
  }
}
