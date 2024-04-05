import 'package:dartz/dartz.dart';
import 'package:fridge/clients/data/models/add_client_request.dart';
import 'package:fridge/clients/domain/repository/client_repository.dart';
import '../../../core/error/failure.dart';

class AddClientUsecase {
  final ClientRepository repository;

  AddClientUsecase(this.repository);

  Future<Either<Failure, void>> call(AddClientRequest request) async {
    return await repository.addClient(request);
  }
}