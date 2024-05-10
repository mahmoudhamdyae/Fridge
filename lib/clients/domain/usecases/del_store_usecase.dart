import 'package:dartz/dartz.dart';
import 'package:fridge/clients/domain/repository/client_repository.dart';
import '../../../core/error/failure.dart';

class DelStoreUsecase {
  final ClientRepository repository;

  DelStoreUsecase(this.repository);

  Future<Either<Failure, void>> call(int storeId) async {
    return await repository.delStore(storeId);
  }
}