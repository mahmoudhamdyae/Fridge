import 'package:dio/dio.dart';
import 'package:fridge/core/network/dio_manager.dart';
import 'package:fridge/reports/data/models/analysis_model.dart';
import 'package:fridge/reports/data/models/month.dart';
import 'package:fridge/reports/data/models/week.dart';

import '../../../core/error/error_message_model.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/network/api_constants.dart';

abstract class ReportsRemoteDataSource {
  final DioManager dioManager;
  ReportsRemoteDataSource(this.dioManager);

  Future<List<AnalysisModel>> getAnalysis();
  Future<Week> getWeek();
  Future<Month> getMonth();
}

class ReportsRemoteDataSourceImpl extends ReportsRemoteDataSource {
  ReportsRemoteDataSourceImpl(super.dioManager);

  @override
  Future<List<AnalysisModel>> getAnalysis() async {
    try {
      var response = await dioManager.dio.get(ApiConstants.getAnalysisPath);
      return AnalysisResponse.fromJson(response.data).data ?? [];
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
  Future<Week> getWeek() async {
    try {
      var response = await dioManager.dio.get(ApiConstants.getWeekPath);
      return WeekResponse.fromJson(response.data).data!;
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
  Future<Month> getMonth() async {
    try {
      var response = await dioManager.dio.get(ApiConstants.getMonthPath);
      return MonthResponse.fromJson(response.data).data!;
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