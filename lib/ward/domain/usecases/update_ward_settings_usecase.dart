import 'package:dartz/dartz.dart';
import 'package:fridge/ward/domain/repository/wards_repository.dart';
import '../../../core/error/failure.dart';

class UpdateWardSettingsUsecase {
  final WardsRepository repository;

  UpdateWardSettingsUsecase(this.repository);

  Future<Either<Failure, void>> call(int wardId, int wardWidth, int wardHeight) async {
    return await repository.updateWardSettings(wardId, wardWidth, wardHeight);
  }
}