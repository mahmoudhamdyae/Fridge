import 'package:dartz/dartz.dart';
import 'package:fridge/core/error/failure.dart';
import 'package:fridge/ward/data/data_source/wards_remote_data_source.dart';
import 'package:fridge/ward/domain/entities/ward.dart';

import '../../../core/error/exceptions.dart';

abstract class WardsRepository {

  final WardsRemoteDataSource remoteDataSource;
  WardsRepository(this.remoteDataSource);

  Future<Either<Failure, List<Ward>>> getWards();
}

class WardsRepositoryImpl extends WardsRepository {

  WardsRepositoryImpl(super.remoteDataSource);

  @override
  Future<Either<Failure, List<Ward>>> getWards() async {
    try {
      var result = await remoteDataSource.getWards();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.message));
    }
  }
}