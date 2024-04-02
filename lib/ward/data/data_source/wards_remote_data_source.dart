import 'dart:io';

import 'package:fridge/core/network/dio_manager.dart';
import 'package:fridge/ward/data/models/ward_model.dart';

import '../../../core/error/error_message_model.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/network/api_constants.dart';

abstract class WardsRemoteDataSource {
  final DioManager dioManager;
  WardsRemoteDataSource(this.dioManager);

  Future<List<WardModel>> getWards();
}

class WardsRemoteDataSourceImpl extends WardsRemoteDataSource {

  WardsRemoteDataSourceImpl(super.dioManager);

  @override
  Future<List<WardModel>> getWards() async {
    try {
      var response = await dioManager.dio.get(
        ApiConstants.getWardsPath,
      );
      if (response.statusCode == HttpStatus.ok) {
        return Wards.fromJson((response.data)).data ?? [];
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
}