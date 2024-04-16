import 'package:dartz/dartz.dart';
import 'package:fridge/core/error/failure.dart';
import 'package:fridge/reports/domain/repository/reports_repository.dart';

import '../../data/models/month.dart';

class GetMonthUsecase {
  final ReportsRepository repository;
  GetMonthUsecase(this.repository);

  Future<Either<Failure, Month>> call() async {
    return await repository.getMonth();
  }
}