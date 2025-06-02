import 'package:easy_localization/easy_localization.dart';
import 'package:base_project/core/caching_utils/caching_utils.dart';
import 'package:base_project/core/helpers/firebase_notification_helper.dart';
import 'package:base_project/core/models/user.dart';
import 'package:base_project/core/network_utils/network_utils.dart';
import 'package:base_project/widgets/snack_bar.dart';

import '../helpers/utils.dart';

class AuthDataSource {
  static Future<bool> login({
    required String phone,
    required String password,
    required bool isSeller,
  }) async {
    try {
      print("login with phone: $phone, password: $password");
      final response = await NetworkUtils.post(
        'users/login',
        data: {
          "phoneNumber": phone,
          'password': password,
          "role": isSeller ? "seller" : "user",
        },
      );
      print(response.data);
      final success = !(response.data['isError'] ?? false);
      if (success) {
        await CachingUtils.cacheAuthData(response.data);
        sendFcm();
      } else {
        showSnackBar((response.data["message"] as String).tr(),
            errorMessage: true);
      }

      return success;
    } catch (e, s) {
      handleGenericException(e, s);
    }
    return false;
  }

  static Future<bool> signUp({
    required String phone,
    required String password,
    required bool isSeller,
    required String name,
    bool? isMale,
  }) async {
    try {
      final response = await NetworkUtils.post(
        'users/signup',
        data: {
          "phoneNumber": phone,
          'password': password,
          'confirmPassword': password,
          "role": isSeller ? "seller" : "user",
          "name": name,
          if (!isSeller && isMale != null) "gender": isMale ? "male" : "female",
        },
      );
      print(11111);
      print(response.data);
      final success = !(response.data['isError'] ?? false);
      if (success) {
        await CachingUtils.cacheAuthData(response.data);
        sendFcm();
      } else {
        showSnackBar(response.data['message'], errorMessage: true);
      }
      return success;
    } catch (e, s) {
      handleGenericException(e, s);
    }
    return false;
  }

  static Future<bool> updateProfile({
    String? phone,
    String? password,
    bool? isSeller,
    String? name,
    bool? isMale,
    bool showError = true,
  }) async {
    try {
      final response = await NetworkUtils.patch(
        'users/${CachingUtils.user.model?.id}',
        data: {
          if (phone != null) "phoneNumber": phone,
          if (password != null) 'password': password,
          if (name != null) "name": name,
          if (isSeller != null) "role": isSeller ? "seller" : "user",
          if (isMale != null) "gender": isMale ? "male" : "female",
        },
      );
      print(response.data);
      final success = !(response.data['isError'] ?? false);
      if (success) {
        await CachingUtils.user.cache(response.data['data']);
      } else {
        if (showError)
          showSnackBar(
            response.data['message'],
            errorMessage: true,
          );
      }
      return success;
    } catch (e, s) {
      if (showError) handleGenericException(e, s);
      return false;
    }
  }

  static Future<void> getMyProfile() async {
    try {
      final response = await NetworkUtils.get(
        'users/getUser/${CachingUtils.user.model?.id}',
      );
      final success = !(response.data['isError'] ?? false);
      print(response.data);
      if (success) {
        await CachingUtils.user.cache(response.data['data']);
        print("user: ${CachingUtils.user.model!..active}");
      } else {
        if (response.data['message'] == "userNotFoundPleaseAuthenticate") {
          await CachingUtils.clearCache();
        }
      }
    } catch (e, s) {
      handleGenericException(e, s);
    }
    return null;
  }

  static Future<User?> getUserById(String id) async {
    try {
      final response = await NetworkUtils.get(
        'users/getUser/$id',
      );
      print("getUserById response: ${response.data}");
      final success = !(response.data['isError'] ?? false);
      if (success) {
        return User.fromJson(response.data['data']);
      } else {
        if (response.data['message'] == "userNotFoundPleaseAuthenticate") {
          await CachingUtils.clearCache();
        }
      }
    } catch (e, s) {
      handleGenericException(e, s);
    }
    return null;
  }

  static Future<bool> deleteUser() async {
    try {
      final response = await NetworkUtils.delete(
        'users/${CachingUtils.user.model!..id}',
      );
      await CachingUtils.clearCache();
      return true;
    } catch (e, s) {
      handleGenericException(e, s);
    }
    return false;
  }

  static Future sendFcm() async {
    try {
      final token = await FirebaseNotificationHelper.messaging.getToken();
      final response = await NetworkUtils.post(
        'users/setFcmToken',
        data: {
          "fcmToken": token,
        },
      );
      print("sendFcmmm response: ${response.data}");

      final success = !(response.data['isError'] ?? false);
      if (!success) {
        showSnackBar(response.data['message'], errorMessage: true);
      }
    } catch (e, s) {
      handleGenericException(e, s);
    }
  }
}
