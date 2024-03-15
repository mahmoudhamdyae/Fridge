import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fridge/core/network/api_constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String applicationJson = "application/json";
const String contentType = "content-type";
const String accept = "accept";
const String authorization = "authorization";

class DioManager {
  static DioManager? _instance;
  static DioManager get instance {
    if (_instance != null) return _instance!;
    _instance = DioManager._init();
    return _instance!;
  }

  late final Dio dio;

  DioManager._init() {
    dio = Dio();

    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: ApiConstants.token,
    };

    dio.options = BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        followRedirects: true,
        headers: headers,
        receiveTimeout: ApiConstants.apiTimeOut,
        sendTimeout: ApiConstants.apiTimeOut,
    );

    if (!kReleaseMode) {
      // It is debug mode so print app logs
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
  }
}