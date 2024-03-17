import 'package:dartz/dartz.dart';
import 'package:fridge/core/error/failure.dart';
import 'package:fridge/home/domain/entities/product.dart';
import 'package:fridge/home/domain/repository/home_repository.dart';

import '../../../core/error/exceptions.dart';

class HomeRepositoryImpl extends HomeRepository {

  HomeRepositoryImpl(super.remoteDataSource);

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final result = await remoteDataSource.getProducts();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, void>> storeProduct(String name, String description) async {
    try {
      await remoteDataSource.storeProduct(name, description);
      return const Right(null);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(int id, String name, String description) async {
    try {
      await remoteDataSource.updateProduct(id, name, description);
      return const Right(null);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, void>> delProduct(int productId) async {
    try {
      await remoteDataSource.delProduct(productId);
      return const Right(null);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.message));
    }
  }
}