import 'package:dartz/dartz.dart';
import 'package:fridge/core/error/failure.dart';
import 'package:fridge/home/data/datasource/home_remote_data_source.dart';
import 'package:fridge/home/domain/entities/product.dart';

abstract class HomeRepository {

  final HomeRemoteDataSource remoteDataSource;
  HomeRepository(this.remoteDataSource);

  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, void>> storeProduct(String name, String description);
  Future<Either<Failure, void>> updateProduct(int id, String name, String description);
  Future<Either<Failure, void>> delProduct(int productId);
}