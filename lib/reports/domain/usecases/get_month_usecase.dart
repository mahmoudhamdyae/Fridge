import 'package:dartz/dartz.dart';
import 'package:fridge/core/error/failure.dart';
import 'package:fridge/reports/domain/entities/month.dart';
import 'package:fridge/reports/domain/repository/reports_repository.dart';

class GetMonthUsecase {
  final ReportsRepository repository;
  GetMonthUsecase(this.repository);

  Future<Either<Failure, List<Month>>> call() async {
    return await repository.getMonth();
  }
}