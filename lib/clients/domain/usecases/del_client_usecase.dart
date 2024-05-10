import 'package:dartz/dartz.dart';
import 'package:fridge/clients/domain/repository/client_repository.dart';
import '../../../core/error/failure.dart';

class DelClientUsecase {
  final ClientRepository repository;

  DelClientUsecase(this.repository);

  Future<Either<Failure, void>> call(int clientId) async {
    return await repository.delClient(clientId);
  }
}