import 'package:dartz/dartz.dart';
import 'package:fridge/reports/data/datasource/reports_remote_data_source.dart';

import '../../../core/error/failure.dart';
import '../entities/analysis.dart';

abstract class ReportsRepository {
  final ReportsRemoteDataSource remoteDataSource;
  ReportsRepository(this.remoteDataSource);

  Future<Either<Failure, List<Analysis>>> getAnalysis();
}