import 'package:dartz/dartz.dart';
import 'package:fridge/core/error/failure.dart';
import 'package:fridge/reports/data/models/year.dart';
import 'package:fridge/reports/domain/repository/reports_repository.dart';

class GetYearUsecase {
  final ReportsRepository repository;
  GetYearUsecase(this.repository);

  Future<Either<Failure, Year>> call() async {
    return await repository.getYear();
  }
}