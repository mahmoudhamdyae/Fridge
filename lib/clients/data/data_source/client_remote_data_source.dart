import 'package:dio/dio.dart';
import 'package:fridge/clients/data/models/add_client_request.dart';
import 'package:fridge/clients/data/models/amount_paid.dart';
import 'package:fridge/clients/data/models/client_model.dart';
import 'package:fridge/clients/domain/entities/client.dart';
import 'package:fridge/core/network/dio_manager.dart';

import '../../../core/error/error_message_model.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/network/api_constants.dart';
import '../models/client_invoice.dart';

abstract class ClientRemoteDataSource {
  final DioManager dioManager;
  ClientRemoteDataSource(this.dioManager);

  Future<List<Client>> getClients();
  Future<void> addClient(AddClientRequest request);
  Future<ClientInvoiceData> getClientInvoice(int clientId);
  Future<void> delStore(int storeId);
  Future<void> delClient(int clientId);
  Future<void> addPaid(int clientId, String paid);
  Future<AmountPaid> getAmountPaid(int clientId);
  Future<void> sahbStore(int storeId, num tons);
}

class ClientRemoteDataSourceImpl extends ClientRemoteDataSource {
  ClientRemoteDataSourceImpl(super.dioManager);

  @override
  Future<List<Client>> getClients() async {
    try {
      var response = await dioManager.dio.get(ApiConstants.getClientsPath);
      return Clients.fromJson((response.data)).data ?? [];
    }  on DioException catch (error) {
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
  Future<void> addClient(AddClientRequest request) async {
    try {
      await dioManager.dio.post(
        ApiConstants.addClientPath,
        data: request.toJson(),
      );
    }  on DioException catch (error) {
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
  Future<ClientInvoiceData> getClientInvoice(int clientId) async {
    try {
      var result = await dioManager.dio.get(ApiConstants.getClientInvoicePath(clientId));
      return ClientInvoiceResponse.fromJson(result.data).data!;
    }  on DioException catch (error) {
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
  Future<void> delClient(int clientId) async {
    try {
      await dioManager.dio.delete(ApiConstants.delClientPath(clientId));
    }  on DioException catch (error) {
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
  Future<void> delStore(int storeId) async {
    try {
      await dioManager.dio.get(ApiConstants.delStorePath(storeId));
    }  on DioException catch (error) {
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
  Future<void> addPaid(int clientId, String paid) async {
    try {
      await dioManager.dio.post(
          ApiConstants.addPaidPath,
          data: {
            'amount_paid': paid,
            'customer_id': clientId
          }
      );
    }  on DioException catch (error) {
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
  Future<AmountPaid> getAmountPaid(int clientId) async {
    try {
      var result = await dioManager.dio.get(
          ApiConstants.getAmountPaidPath,
          data: {
            'customer_id': clientId
          }
      );
      return AmountPaid.fromJson(result.data);
    }  on DioException catch (error) {
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
  Future<void> sahbStore(int storeId, num tons) async {
    try {
      await dioManager.dio.post(ApiConstants.sahbStore(storeId, tons));
    }  on DioException catch (error) {
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