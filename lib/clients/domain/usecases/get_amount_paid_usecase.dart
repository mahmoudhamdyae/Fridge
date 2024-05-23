import 'package:dartz/dartz.dart';
import 'package:fridge/clients/domain/entities/amount_paid.dart';
import 'package:fridge/clients/domain/repository/client_repository.dart';
import '../../../core/error/failure.dart';

class GetAmountPaidUsecase {
  final ClientRepository repository;

  GetAmountPaidUsecase(this.repository);

  Future<Either<Failure, List<AllAmount>>> call(int clientId) async {
    return await repository.getAmountPaid(clientId);
  }
}