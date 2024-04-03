import 'package:dartz/dartz.dart';
import 'package:fridge/clients/domain/entities/client.dart';
import 'package:fridge/clients/domain/repository/client_repository.dart';
import '../../../core/error/failure.dart';

class GetClientsUsecase {
  final ClientRepository repository;

  GetClientsUsecase(this.repository);

  Future<Either<Failure, List<Client>>> call() async {
    return await repository.getClients();
  }
}