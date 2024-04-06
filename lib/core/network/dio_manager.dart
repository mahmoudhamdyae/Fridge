import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fridge/core/network/api_constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'connectivity_controller.dart';

const String applicationJson = "application/json;charset=utf-8";
const String contentType = "utf-8";
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

    dio.options = BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        followRedirects: true,
        receiveTimeout: ApiConstants.apiTimeOut,
        sendTimeout: ApiConstants.apiTimeOut,
    );

    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          ConnectivityController.checkConnectivity();
          // Add the access token to the request header
          options.headers['Authorization'] = 'Bearer ${ApiConstants.token}';
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401 && !ApiConstants.isAuth) {
            // If a 401 response is received, refresh the access token
            String newAccessToken = ApiConstants.token; // Refresh Token

            // Update the request header with the new access token
            e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

            // Repeat the request with the updated header
            return handler.resolve(await dio.fetch(e.requestOptions));
          }
          return handler.next(e);
        },
      ),
    );
  }
}