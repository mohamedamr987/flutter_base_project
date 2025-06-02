import 'dart:convert';
import 'package:base_project/core/caching_utils/caching_utils.dart';

class CachingModel<T> {
  final String _cachingKey;
  final T Function(Map<String, dynamic> json)? fromJson;

  CachingModel({required String cachingKey, this.fromJson})
      : _cachingKey = cachingKey;

  T? get model {
    if (CachingUtils.sharedPreferences.containsKey(_cachingKey)) {
      if (T is String) {
        return CachingUtils.sharedPreferences.getString(_cachingKey) as T;
      } else {
        return fromJson!(
          jsonDecode(CachingUtils.sharedPreferences.getString(_cachingKey)!),
        );
      }
    }
    return null;
  }

  Future<void> cache(value) async {
    await CachingUtils.sharedPreferences.setString(
      _cachingKey,
      value is String ? value : jsonEncode(value),
    );
  }

  Future<void> remove() async {
    await CachingUtils.sharedPreferences.remove(_cachingKey);
  }
}
