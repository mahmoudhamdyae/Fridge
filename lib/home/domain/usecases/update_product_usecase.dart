import 'package:dartz/dartz.dart';
import 'package:fridge/home/domain/repository/home_repository.dart';
import '../../../core/error/failure.dart';

class UpdateProductUsecase {
  final HomeRepository repository;

  UpdateProductUsecase(this.repository);

  Future<Either<Failure, void>> call(int id, String name, String description) async {
    return await repository.updateProduct(id, name, description);
  }
}