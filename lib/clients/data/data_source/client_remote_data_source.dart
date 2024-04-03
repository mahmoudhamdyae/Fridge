import 'dart:io';

import 'package:fridge/clients/data/models/client_model.dart';
import 'package:fridge/clients/domain/entities/client.dart';
import 'package:fridge/core/network/dio_manager.dart';

import '../../../core/error/error_message_model.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/network/api_constants.dart';

abstract class ClientRemoteDataSource {
  final DioManager dioManager;
  ClientRemoteDataSource(this.dioManager);

  Future<List<Client>> getClients();
}

class ClientRemoteDataSourceImpl extends ClientRemoteDataSource {
  ClientRemoteDataSourceImpl(super.dioManager);

  @override
  Future<List<Client>> getClients() async {
    try {
      var response = await dioManager.dio.get(ApiConstants.getClientsPath);
      if (response.statusCode == HttpStatus.ok) {
        return Clients.fromJson((response.data)).data ?? [];
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