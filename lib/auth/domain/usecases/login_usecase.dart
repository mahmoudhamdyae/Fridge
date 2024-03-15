import 'package:dartz/dartz.dart';
import 'package:fridge/auth/domain/repository/auth_repository.dart';
import '../../../core/error/failure.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase(this.repository);

  Future<Either<Failure, void>> call(String phone, String password) async {
    return await repository.login(phone: phone, password: password);
  }
}