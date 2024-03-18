import 'package:dartz/dartz.dart';
import 'package:fridge/core/error/failure.dart';
import 'package:fridge/home/domain/entities/product.dart';
import 'package:fridge/home/domain/repository/home_repository.dart';

class MockHomeRepository extends HomeRepository {

  bool _shouldReturnError = false;
  MockHomeRepository(super.remoteDataSource);

  void returnError(bool error) {
    _shouldReturnError = error;
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    if (_shouldReturnError) {
      return const Left(ServerFailure('ERROR'));
    } else {
      return const Right([]);
    }
  }

  @override
  Future<Either<Failure, void>> storeProduct(String name, String description) async {
    if (_shouldReturnError) {
      return const Left(ServerFailure('ERROR'));
    } else {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(int id, String name, String description) async {
    if (_shouldReturnError) {
      return const Left(ServerFailure('ERROR'));
    } else {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, void>> delProduct(int productId) async {
    if (_shouldReturnError) {
      return const Left(ServerFailure('ERROR'));
    } else {
      return const Right(null);
  }
  }
}