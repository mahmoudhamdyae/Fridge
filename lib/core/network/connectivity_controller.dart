import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fridge/core/resources/app_strings.dart';

import '../error/error_message_model.dart';
import '../error/exceptions.dart';

class ConnectivityController {
  static bool isConnected = false;

  Future<void> init() async {
    final List<ConnectivityResult> result =
        await Connectivity().checkConnectivity();
    isInternetConnected(result);
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      isInternetConnected(result);
    });
  }

  bool isInternetConnected(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.none)) {
      isConnected = false;
      return false;
    } else if (result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi)) {
      isConnected = true;
      return true;
    }
    return false;
  }

  static checkConnectivity() {
    if (!isConnected) {
      throw const ServerException(
          errorMessageModel: ErrorMessageModel(
              status: false, message: AppStrings.noConnection));
    }
  }
}
