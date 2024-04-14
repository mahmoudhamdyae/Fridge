import 'package:dartz/dartz.dart';

import 'package:fridge/core/error/failure.dart';

import 'package:fridge/reports/domain/entities/analysis.dart';
import 'package:fridge/reports/domain/entities/month.dart';
import 'package:fridge/reports/domain/entities/week.dart';

import '../../../core/error/exceptions.dart';
import '../../domain/repository/reports_repository.dart';

class ReportsRepositoryImpl extends ReportsRepository {
  ReportsRepositoryImpl(super.remoteDataSource);

  @override
  Future<Either<Failure, List<Analysis>>> getAnalysis() async {
    try {
      var result = await remoteDataSource.getAnalysis();
      return Right(result);
    } on ServerException catch(failure) {
      return Left(ServerFailure(failure.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, List<Week>>> getWeek() async {
    try {
      var result = await remoteDataSource.getWeek();
      return Right(result);
    } on ServerException catch(failure) {
      return Left(ServerFailure(failure.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, List<Month>>> getMonth() async {
    try {
      var result = await remoteDataSource.getMonth();
      return Right(result);
    } on ServerException catch(failure) {
      return Left(ServerFailure(failure.errorMessageModel.message));
    }
  }
}