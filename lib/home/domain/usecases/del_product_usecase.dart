import 'package:dartz/dartz.dart';
import 'package:fridge/home/domain/repository/home_repository.dart';
import '../../../core/error/failure.dart';

class DelProductUsecase {
  final HomeRepository repository;

  DelProductUsecase(this.repository);

  Future<Either<Failure, void>> call(int productId) async {
    return await repository.delProduct(productId);
  }
}