import 'package:dartz/dartz.dart';
import 'package:fridge/clients/data/data_source/client_remote_data_source.dart';
import 'package:fridge/clients/data/models/client_invoice.dart';
import 'package:fridge/clients/domain/entities/client.dart';
import 'package:fridge/core/error/failure.dart';

import '../../data/models/add_client_request.dart';
import '../../data/models/amount_paid.dart';

abstract class ClientRepository {
  final ClientRemoteDataSource remoteDataSource;
  ClientRepository(this.remoteDataSource);

  Future<Either<Failure, List<Client>>> getClients();
  Future<Either<Failure, void>> addClient(AddClientRequest request);
  Future<Either<Failure, ClientInvoiceData>> getClientInvoice(int clientId);
  Future<Either<Failure, void>> delStore(int storeId);
  Future<Either<Failure, void>> delClient(int clientId);
  Future<Either<Failure, void>> addPaid(int clientId, String paid);
  Future<Either<Failure, AmountPaid>> getAmountPaid(int clientId);
  Future<Either<Failure, void>> sahbStore(int storeId, num tons);
}