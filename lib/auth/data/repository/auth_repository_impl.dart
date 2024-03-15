import 'package:dartz/dartz.dart';
import 'package:fridge/auth/domain/repository/auth_repository.dart';
import 'package:fridge/core/error/exceptions.dart';

import '../../../core/error/failure.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl(super.localDataSource, super.remoteDataSource);

  // Local Data Source

  @override
  Either<Failure, bool> isFirstEntry() {
    try {
      bool firstEntry = localDataSource.isFirstEntry();
      return Right(firstEntry);
    } on LocalDatabaseException catch(failure) {
      return Left(DatabaseFailure(failure.message));
    }
  }

  @override
  Either<Failure, bool> isLoggedIn() {
    try {
      bool isUserLoggedIn = localDataSource.isLoggedIn();
      return Right(isUserLoggedIn);
    } on LocalDatabaseException catch(failure) {
      return Left(DatabaseFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      localDataSource.signOut();
      return const Right(null);
    } on LocalDatabaseException catch(failure) {
      return Left(DatabaseFailure(failure.message));
    }
  }

  // Remote Data Source

  @override
  Future<Either<Failure, void>> login({required String phone, required String password}) async {
    try {
      final result = await remoteDataSource.login(phone: phone, password: password);
      localDataSource.updateToken(result);
      return const Right(null);
    } on ServerException catch(failure) {
      return Left(ServerFailure(failure.errorMessageModel.message));
    } on LocalDatabaseException catch(failure) {
      return Left(DatabaseFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, void>> register({required String name, required String phone, required String password, required String confirmPassword}) async {
    try {
      final result = await remoteDataSource.register(name: name, phone: phone, password: password, confirmPassword: confirmPassword);
      localDataSource.updateToken(result);
      return const Right(null);
    } on ServerException catch(failure) {
      return Left(ServerFailure(failure.errorMessageModel.message));
    } on LocalDatabaseException catch(failure) {
      return Left(DatabaseFailure(failure.message));
    }
  }
}