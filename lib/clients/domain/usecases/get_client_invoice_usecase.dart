import 'package:dartz/dartz.dart';
import 'package:fridge/clients/domain/repository/client_repository.dart';
import '../../../core/error/failure.dart';
import '../../data/models/client_invoice.dart';

class GetClientInvoiceUsecase {
  final ClientRepository repository;

  GetClientInvoiceUsecase(this.repository);

  Future<Either<Failure, ClientInvoiceData>> call(int clientId) async {
    return await repository.getClientInvoice(clientId);
  }
}