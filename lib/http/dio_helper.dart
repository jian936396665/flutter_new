import 'package:dio/dio.dart';
import 'package:flutter_app_new/http/constants.dart';
import 'package:flutter_app_new/http/header_intercept.dart';

class DioHelper {

  static var _dio;

  static Dio getInstance() {
    if (_dio == null) {
      _dio = new Dio()
        ..options = BaseOptions(
            baseUrl: Constants.baseUrl,
            connectTimeout: 30000,
            receiveTimeout: 30000)
        ..interceptors.add(HeaderInterceptor())
        ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    }
    return _dio;
  }

}
