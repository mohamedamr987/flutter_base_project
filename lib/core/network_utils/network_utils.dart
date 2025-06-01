import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import '../caching_utils/caching_utils.dart';

class NetworkUtils {
  static const String eljomla = "https://souqeljomla.online/";
  static const String dates = "https://souqdates.shop/";
  static const String baseUrl = appFlavor == "eljomla" ? eljomla : dates;
  static const String _baseUrl = "${baseUrl}api/v1/";
  static late Dio _dio;

  static Future<void> init() async {
    // add timeout
    _dio = Dio(
        // BaseOptions(
        //   connectTimeout: Duration(seconds: 10),
        //   receiveTimeout: Duration(seconds: 10),
        // ),
        )
      ..options.baseUrl = _baseUrl;
    _dio.options.validateStatus = (status) => true;
  }

  static Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    _dio = Dio(
        // BaseOptions(
        //   connectTimeout: Duration(seconds: 10),
        //   receiveTimeout: Duration(seconds: 10),
        // ),
        )
      ..options.baseUrl = _baseUrl;
    _dio.options.validateStatus = (status) => true;
    _dio.options.headers = {
      if (CachingUtils.token != null)
        'Authorization': "Bearer ${CachingUtils.token ?? ''}",
    };
    print(path);
    if (headers != null) {
      _dio.options.headers.addAll(headers);
    }
    // throw Exception();
    print(path);
    print(_dio.options.headers);
    return await _dio.get(
      path,
      cancelToken: cancelToken,
    );
  }

  static Future<Response<dynamic>> post(String path,
      {Map<String, dynamic>? data,
      FormData? formData,
      Map<String, dynamic>? headers}) async {
    print(data);
    print("path: $path");
    _dio.options.headers = {
      if (CachingUtils.token != null)
        'Authorization': "Bearer ${CachingUtils.token ?? ''}",
    };
    if (headers != null) {
      _dio.options.headers.addAll(headers);
    }
    return await _dio.post(path, data: formData ?? data);
  }

  static Future<Response<dynamic>> patch(String path,
      {Map<String, dynamic>? data,
      FormData? formData,
      Map<String, dynamic>? headers}) async {
    _dio.options.headers = {
      if (CachingUtils.token != null)
        'Authorization': "Bearer ${CachingUtils.token ?? ''}",
    };
    if (headers != null) {
      _dio.options.headers.addAll(headers);
    }
    print(_dio.options.headers);
    print("path: $path");
    return await _dio.patch(path, data: formData ?? data);
  }

  static Future<Response<dynamic>> delete(String path,
      {Map<String, dynamic>? data,
      FormData? formData,
      Map<String, dynamic>? headers}) async {
    _dio.options.headers = {
      if (CachingUtils.token != null)
        'Authorization': "Bearer ${CachingUtils.token ?? ''}",
    };
    if (headers != null) {
      _dio.options.headers.addAll(headers);
    }
    return await _dio.delete(path, data: formData ?? data);
  }
}
