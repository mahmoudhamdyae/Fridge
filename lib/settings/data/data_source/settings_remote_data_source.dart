import 'package:dio/dio.dart';

import '../../../core/error/error_message_model.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/dio_manager.dart';
import '../models/settings_request.dart';
import '../models/settings_response_model.dart';

abstract class SettingsRemoteDataSource {

  final DioManager dioManager;
  SettingsRemoteDataSource(this.dioManager);

  Future<SettingsResponseModel> getSettings();
  Future<void> updateSettings(SettingsRequest request);
}

class SettingsRemoteDataSourceImpl extends SettingsRemoteDataSource {

  SettingsRemoteDataSourceImpl(super.dioManager);

  @override
  Future<SettingsResponseModel> getSettings() async {
    try {
      var response = await dioManager.dio.get(
          ApiConstants.getSettingsPath,
      );
      return SettingsResponseModel.fromJson((response.data));
    }  on DioException catch (error) {
      if (error.response != null) {
        throw ServerException(
            errorMessageModel: ErrorMessageModel.fromJson(error.response?.data)
        );
      } else {
        // Error due to setting up or sending the request
        throw ServerException(
            errorMessageModel: ErrorMessageModel(status: false, message: error.message ?? '')
        );
      }
    }
  }

  @override
  Future<void> updateSettings(SettingsRequest request) async {
    try {
      await dioManager.dio.post(
        ApiConstants.updateSettingsPath,
        data: request.toJson(),
      );
    }  on DioException catch (error) {
      if (error.response != null) {
        throw ServerException(
            errorMessageModel: ErrorMessageModel.fromJson(error.response?.data)
        );
      } else {
        // Error due to setting up or sending the request
        throw ServerException(
            errorMessageModel: ErrorMessageModel(status: false, message: error.message ?? '')
        );
      }
    }
  }
}