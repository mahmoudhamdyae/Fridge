import 'package:dartz/dartz.dart';
import 'package:fridge/settings/data/models/settings_request.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failure.dart';
import '../../domain/entities/settings_response.dart';
import '../../domain/repository/settings_repository.dart';

class SettingsRepositoryImpl extends SettingsRepository  {

  SettingsRepositoryImpl(super.remoteDataSource);

  @override
  Future<Either<Failure, SettingsResponse>> getSettings() async {
    try {
      var result = await remoteDataSource.getSettings();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateSettings(SettingsRequest request) async {
    try {
      await remoteDataSource.updateSettings(request);
      return const Right(null);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.message));
    }
  }
}