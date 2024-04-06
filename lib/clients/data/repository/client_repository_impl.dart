import 'package:dartz/dartz.dart';
import 'package:fridge/clients/data/models/add_client_request.dart';
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
      await remoteDataSource.getClients();
      return const Right(null);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }
}