import 'package:dartz/dartz.dart';
import 'package:fridge/core/error/failure.dart';
import 'package:fridge/reports/data/models/week.dart';
import 'package:fridge/reports/domain/repository/reports_repository.dart';

class GetWeekUsecase {
  final ReportsRepository repository;
  GetWeekUsecase(this.repository);

  Future<Either<Failure, Week>> call() async {
    return await repository.getWeek();
  }
}