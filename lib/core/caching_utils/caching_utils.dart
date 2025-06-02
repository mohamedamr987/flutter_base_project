import 'package:base_project/core/caching_utils/caching_model.dart';
import 'package:base_project/core/models/user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CachingUtils {
  static CachingModel<User> user =
      CachingModel<User>(cachingKey: 'logged_user', fromJson: User.fromJson);
  static CachingModel<String> token = CachingModel<String>(
    cachingKey: 'token',
  );

  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> cacheAuthData(Map<String, dynamic> data) async {
    await token.cache(data['token'] ?? '');
    await user.cache(data['user'] ?? '');
  }

  static Future<void> clearCache() async {
    try {
      FirebaseMessaging.instance.unsubscribeFromTopic("admin");
    } catch (e) {
      print(e);
    }
    await sharedPreferences.clear();
  }
}
