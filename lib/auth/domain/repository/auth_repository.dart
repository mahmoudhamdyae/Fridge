import 'package:dartz/dartz.dart';
import 'package:fridge/auth/data/datasource/auth_local_data_source.dart';
import 'package:fridge/auth/data/datasource/auth_remote_data_source.dart';
import 'package:fridge/core/error/failure.dart';

abstract class AuthRepository {

  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSource remoteDataSource;

  AuthRepository(this.localDataSource, this.remoteDataSource);

  // Local Data Source

  Either<Failure, bool> isFirstEntry();
  Either<Failure, bool> isLoggedIn();
  Future<Either<Failure, void>> signOut();

  // Remote Data Source

  Future<Either<Failure, void>> login({
    required String phone,
    required String password,
  });

  Future<Either<Failure, void>> register({
    required String name,
    required String phone,
    required String password,
    required String address,
  });
}