import 'package:dartz/dartz.dart';
import 'package:fridge/home/domain/entities/product.dart';
import 'package:fridge/home/domain/repository/home_repository.dart';
import '../../../core/error/failure.dart';

class GetProductsUsecase {
  final HomeRepository repository;

  GetProductsUsecase(this.repository);

  Future<Either<Failure, List<Product>>> call() async {
    return await repository.getProducts();
  }
}