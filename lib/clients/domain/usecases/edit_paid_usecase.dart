import 'package:dartz/dartz.dart';
import 'package:fridge/clients/domain/repository/client_repository.dart';
import '../../../core/error/failure.dart';

class EditPaidUsecase {
  final ClientRepository repository;

  EditPaidUsecase(this.repository);

  Future<Either<Failure, void>> call(int storeId, String paid) async {
    return await repository.editPaid(storeId, paid);
  }
}