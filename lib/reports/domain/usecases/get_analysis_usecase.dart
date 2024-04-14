import 'package:dartz/dartz.dart';
import 'package:fridge/core/error/failure.dart';
import 'package:fridge/reports/domain/entities/analysis.dart';
import 'package:fridge/reports/domain/repository/reports_repository.dart';

class GetAnalysisUsecase {
  final ReportsRepository repository;
  GetAnalysisUsecase(this.repository);

  Future<Either<Failure, List<Analysis>>> call() async {
    return await repository.getAnalysis();
  }
}