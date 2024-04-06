import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failure.dart';
import '../../domain/entities/ward.dart';
import '../../domain/repository/wards_repository.dart';

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

  @override
  Future<Either<Failure, void>> updateWardSettings(int wardId, int wardWidth, int wardHeight) async {
    try {
      await remoteDataSource.updateWardSettings(wardId, wardWidth, wardHeight);
      return const Right(null);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.message));
    }
  }
}