import 'package:dartz/dartz.dart';
import 'package:fridge/reports/data/datasource/reports_remote_data_source.dart';
import 'package:fridge/reports/data/models/week.dart';

import '../../../core/error/failure.dart';
import '../../data/models/month.dart';
import '../entities/analysis.dart';

abstract class ReportsRepository {
  final ReportsRemoteDataSource remoteDataSource;
  ReportsRepository(this.remoteDataSource);

  Future<Either<Failure, List<Analysis>>> getAnalysis();
  Future<Either<Failure, Week>> getWeek();
  Future<Either<Failure, Month>> getMonth();
}