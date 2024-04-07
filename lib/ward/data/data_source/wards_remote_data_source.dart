import 'package:dio/dio.dart';
import 'package:fridge/core/network/dio_manager.dart';
import 'package:fridge/ward/data/models/invoice.dart';
import 'package:fridge/ward/data/models/store.dart';
import 'package:fridge/ward/data/models/ward_model.dart';

import '../../../core/error/error_message_model.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/network/api_constants.dart';

abstract class WardsRemoteDataSource {
  final DioManager dioManager;
  WardsRemoteDataSource(this.dioManager);

  Future<List<WardModel>> getWards();
  Future<void> updateWardSettings(int wardId, int wardWidth, int wardHeight);
  Future<List<Store>> getAllStore(int wardId);
  Future<Invoice?> getInvoice(int storeId);
}

class WardsRemoteDataSourceImpl extends WardsRemoteDataSource {

  WardsRemoteDataSourceImpl(super.dioManager);

  @override
  Future<List<WardModel>> getWards() async {
    try {
      var response = await dioManager.dio.get(
        ApiConstants.getWardsPath,
      );
      return Wards.fromJson((response.data)).data ?? [];
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
  Future<void> updateWardSettings(int wardId, int wardWidth, int wardHeight) async {
    try {
      await dioManager.dio.post(
        ApiConstants.updateWardSettingsPath,
        data: {
          'id': wardId,
          'width': wardWidth,
          'height': wardHeight,
        }
      );
    } on DioException catch (error) {
      if (error.response != null) {
        throw ServerException(
            errorMessageModel: ErrorMessageModel.fromJson(error.response?.data)
        );
      } else {
        throw ServerException(
            errorMessageModel: ErrorMessageModel(status: false, message: error.message ?? '')
        );
      }
    }
  }

  @override
  Future<List<Store>> getAllStore(int wardId) async {
    try {
      var response = await dioManager.dio.get(
        ApiConstants.getAllStorePath(wardId),
      );
      return StoreResponse.fromJson((response.data)).data?? [];
    } on DioException catch (error) {
      if (error.response != null) {
        throw ServerException(
            errorMessageModel: ErrorMessageModel.fromJson(error.response?.data)
        );
      } else {
        throw ServerException(
            errorMessageModel: ErrorMessageModel(status: false, message: error.message ?? '')
        );
      }
    }
  }

  @override
  Future<Invoice?> getInvoice(int storeId) async {
    try {
      var response = await dioManager.dio.get(
        ApiConstants.getInvoicePath(storeId),
      );
      return InvoiceResponse.fromJson((response.data)).data;
    } on DioException catch (error) {
      if (error.response != null) {
        throw ServerException(
            errorMessageModel: ErrorMessageModel.fromJson(error.response?.data)
        );
      } else {
        throw ServerException(
            errorMessageModel: ErrorMessageModel(status: false, message: error.message ?? '')
        );
      }
    }
  }
}