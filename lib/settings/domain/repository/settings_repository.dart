import 'package:dartz/dartz.dart';
import 'package:fridge/settings/data/data_source/settings_remote_data_source.dart';
import 'package:fridge/settings/domain/entities/settings_response.dart';

import '../../../core/error/failure.dart';
import '../../data/models/settings_request.dart';

abstract class SettingsRepository {

  final SettingsRemoteDataSource remoteDataSource;
  SettingsRepository(this.remoteDataSource);

  Future<Either<Failure, SettingsResponse>> getSettings();
  Future<Either<Failure, void>> updateSettings(SettingsRequest request);
}