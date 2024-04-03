import 'package:dartz/dartz.dart';
import 'package:fridge/clients/data/data_source/client_remote_data_source.dart';
import 'package:fridge/clients/domain/entities/client.dart';
import 'package:fridge/core/error/failure.dart';

abstract class ClientRepository {
  final ClientRemoteDataSource remoteDataSource;
  ClientRepository(this.remoteDataSource);

  Future<Either<Failure, List<Client>>> getClients();
}

class ClientRepositoryImpl extends ClientRepository {
  ClientRepositoryImpl(super.remoteDataSource);

  @override
  Future<Either<Failure, List<Client>>> getClients() async {
    try {
      var response = await remoteDataSource.getClients();
      return Right(response);
    } on Exception catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}