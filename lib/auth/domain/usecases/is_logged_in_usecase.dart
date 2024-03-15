import 'package:dartz/dartz.dart';
import 'package:fridge/auth/domain/repository/auth_repository.dart';
import '../../../core/error/failure.dart';

class IsLoggedInUsecase {
  final AuthRepository repository;

  IsLoggedInUsecase(this.repository);

  Either<Failure, bool> call() {
    return repository.isLoggedIn();
  }
}