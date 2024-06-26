import 'package:dartz/dartz.dart';
import 'package:fridge/ward/domain/repository/wards_repository.dart';
import '../../../core/error/failure.dart';
import '../entities/invoice.dart';

class GetInvoiceUsecase {
  final WardsRepository repository;

  GetInvoiceUsecase(this.repository);

  Future<Either<Failure, Invoice>> call(int storeId) async {
    return await repository.getInvoice(storeId);
  }
}