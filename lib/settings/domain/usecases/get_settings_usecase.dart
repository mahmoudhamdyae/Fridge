import 'package:dartz/dartz.dart';
import 'package:fridge/settings/domain/entities/settings_response.dart';
import 'package:fridge/settings/domain/repository/settings_repository.dart';
import '../../../core/error/failure.dart';

class GetSettingsUsecase {
  final SettingsRepository repository;

  GetSettingsUsecase(this.repository);

  Future<Either<Failure, SettingsResponse>> call() async {
    return await repository.getSettings();
  }
}