import 'package:dio/dio.dart';
import 'package:fridge/core/network/api_constants.dart';
import 'package:fridge/core/network/dio_manager.dart';
import 'package:fridge/expenses/data/models/expenses_response_model.dart';

import '../../../core/error/error_message_model.dart';
import '../../../core/error/exceptions.dart';
import '../../domain/entities/expenses_response.dart';
import '../models/expense_type_model.dart';
import '../models/expenses_request_model.dart';

abstract class ExpensesRemoteDataSource {
  final DioManager dioManager;
  ExpensesRemoteDataSource(this.dioManager);

  Future<void> storeExpenses(String title, String date, String description, String amount);
  Future<List<ExpensesResponse>> getExpenses();
  Future<List<ExpenseTypeModel>> getExpenseTypes();
}

class ExpensesRemoteDataSourceImpl extends ExpensesRemoteDataSource {
  ExpensesRemoteDataSourceImpl(super.dioManager);

  @override
  Future<void> storeExpenses(String title, String date, String description, String amount) async {
    try {
      await dioManager.dio.post(
          ApiConstants.storeExpensePath,
          data: ExpensesRequestModel(
            title: title,
            date: date,
            description: description,
            amount: amount
        ).toJson()
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
  Future<List<ExpensesResponse>> getExpenses() async {
    try {
      var result = await dioManager.dio.get(ApiConstants.getExpensePath);
      return ExpensesResponsesFullResponse.fromJson(result.data).data ?? [];
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
  Future<List<ExpenseTypeModel>> getExpenseTypes() async {
    try {
      var result = await dioManager.dio.get(ApiConstants.getExpenseTypesPath);
      return ExpenseTypeResponse.fromJson(result.data).data ?? [];
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