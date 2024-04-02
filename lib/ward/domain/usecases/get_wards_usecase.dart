import 'package:dartz/dartz.dart';
import 'package:fridge/ward/domain/entities/ward.dart';
import 'package:fridge/ward/domain/repository/wards_repository.dart';
import '../../../core/error/failure.dart';

class GetWardsUsecase {
  final WardsRepository repository;

  GetWardsUsecase(this.repository);

  Future<Either<Failure, List<Ward>>> call() async {
    return await repository.getWards();
  }
}