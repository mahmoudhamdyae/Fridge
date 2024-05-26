import 'package:dartz/dartz.dart';
import 'package:fridge/clients/domain/repository/client_repository.dart';
import '../../../core/error/failure.dart';
import '../../data/models/amount_paid.dart';

class GetAmountPaidUsecase {
  final ClientRepository repository;

  GetAmountPaidUsecase(this.repository);

  Future<Either<Failure, AmountPaid>> call(int clientId) async {
    return await repository.getAmountPaid(clientId);
  }
}