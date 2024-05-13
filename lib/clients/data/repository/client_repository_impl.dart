import 'package:dartz/dartz.dart';
import 'package:fridge/clients/data/models/add_client_request.dart';
import 'package:fridge/clients/data/models/client_invoice.dart';
import 'package:fridge/core/error/exceptions.dart';

import '../../../core/error/failure.dart';
import '../../domain/entities/client.dart';
import '../../domain/repository/client_repository.dart';

class ClientRepositoryImpl extends ClientRepository {
  ClientRepositoryImpl(super.remoteDataSource);

  @override
  Future<Either<Failure, List<Client>>> getClients() async {
    try {
      var response = await remoteDataSource.getClients();
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, void>> addClient(AddClientRequest request) async {
    try {
      await remoteDataSource.addClient(request);
      return const Right(null);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, ClientInvoiceData>> getClientInvoice(int clientId) async {
    try {
      var response = await remoteDataSource.getClientInvoice(clientId);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, void>> delClient(int clientId) async {
    try {
      var response = await remoteDataSource.delClient(clientId);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, void>> delStore(int storeId) async {
    try {
      var response = await remoteDataSource.delStore(storeId);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, void>> editPaid(int storeId, String paid) async {
    try {
      var response = await remoteDataSource.editPaid(storeId, paid);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }
}