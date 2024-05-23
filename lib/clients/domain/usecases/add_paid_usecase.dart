import 'package:dartz/dartz.dart';
import 'package:fridge/clients/domain/repository/client_repository.dart';
import '../../../core/error/failure.dart';

class AddPaidUsecase {
  final ClientRepository repository;

  AddPaidUsecase(this.repository);

  Future<Either<Failure, void>> call(int clientId, String paid) async {
    return await repository.addPaid(clientId, paid);
  }
}