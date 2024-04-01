import 'dart:io';

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
      var response = await dioManager.dio.get(ApiConstants.getSettingsPath);
      if (response.statusCode == HttpStatus.ok) {
        return SettingsResponseModel.fromJson((response.data));
      } else {
        throw ServerException(
            errorMessageModel: ErrorMessageModel.fromJson(response.data)
        );
      }
    } on Exception catch (error) {
      throw ServerException(
          errorMessageModel: ErrorMessageModel(status: false, message: error.toString())
      );
    }
  }

  @override
  Future<void> updateSettings(SettingsRequest request) async {
    try {
      var response = await dioManager.dio.post(
        ApiConstants.loginPath,
        data: request.toJson(),
      );
      if (response.statusCode != HttpStatus.ok) {
        throw ServerException(
            errorMessageModel: ErrorMessageModel.fromJson(response.data)
        );
      }
    } on Exception catch (error) {
      throw ServerException(
          errorMessageModel: ErrorMessageModel(status: false, message: error.toString())
      );
    }
  }
}