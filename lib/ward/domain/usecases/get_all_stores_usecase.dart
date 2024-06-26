import 'package:dartz/dartz.dart';
import 'package:fridge/ward/domain/repository/wards_repository.dart';
import '../../../core/error/failure.dart';
import '../entities/store.dart';

class GetAllStoresUsecase {
  final WardsRepository repository;

  GetAllStoresUsecase(this.repository);

  Future<Either<Failure, List<Store>>> call(int wardId) async {
    return await repository.getAllStore(wardId);
  }
}