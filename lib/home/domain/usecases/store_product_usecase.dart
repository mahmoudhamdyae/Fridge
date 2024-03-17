import 'package:dartz/dartz.dart';
import 'package:fridge/home/domain/repository/home_repository.dart';
import '../../../core/error/failure.dart';

class StoreProductUsecase {
  final HomeRepository repository;

  StoreProductUsecase(this.repository);

  Future<Either<Failure, void>> call(String name, String description) async {
    return await repository.storeProduct(name, description);
  }
}