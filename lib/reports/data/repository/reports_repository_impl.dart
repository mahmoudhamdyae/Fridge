import 'package:dartz/dartz.dart';

import 'package:fridge/core/error/failure.dart';

import 'package:fridge/reports/domain/entities/analysis.dart';

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
}