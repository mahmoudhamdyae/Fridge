import 'package:dartz/dartz.dart';
import 'package:fridge/auth/domain/repository/auth_repository.dart';
import '../../../core/error/failure.dart';

class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  Future<Either<Failure, void>> call(String name, String phone, String password, String address) async {
    return await repository.register(name: name, phone: phone, password: password, address: address);
  }
}