import 'package:dartz/dartz.dart';
import 'package:fridge/clients/domain/repository/client_repository.dart';
import '../../../core/error/failure.dart';

class SahbStoreUsecase {
  final ClientRepository repository;

  SahbStoreUsecase(this.repository);

  Future<Either<Failure, void>> call(int storeId, num tons) async {
    return await repository.sahbStore(storeId, tons);
  }
}