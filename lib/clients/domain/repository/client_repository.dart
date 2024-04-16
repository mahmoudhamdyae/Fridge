import 'package:dartz/dartz.dart';
import 'package:fridge/clients/data/data_source/client_remote_data_source.dart';
import 'package:fridge/clients/data/models/client_invoice.dart';
import 'package:fridge/clients/domain/entities/client.dart';
import 'package:fridge/core/error/failure.dart';

import '../../data/models/add_client_request.dart';

abstract class ClientRepository {
  final ClientRemoteDataSource remoteDataSource;
  ClientRepository(this.remoteDataSource);

  Future<Either<Failure, List<Client>>> getClients();
  Future<Either<Failure, void>> addClient(AddClientRequest request);
  Future<Either<Failure, ClientInvoiceData>> getClientInvoice(int clientId);
}