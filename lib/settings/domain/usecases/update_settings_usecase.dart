import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../data/models/settings_request.dart';
import '../repository/settings_repository.dart';

class UpdateSettingsUsecase {
  final SettingsRepository repository;

  UpdateSettingsUsecase(this.repository);

  Future<Either<Failure, void>> call(SettingsRequest request) async {
    return await repository.updateSettings(request);
  }
}