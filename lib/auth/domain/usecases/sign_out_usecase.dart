import 'package:dartz/dartz.dart';
import 'package:fridge/auth/domain/repository/auth_repository.dart';
import '../../../core/error/failure.dart';

class SignOutUsecase {
  final AuthRepository repository;

  SignOutUsecase(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.signOut();
  }
}