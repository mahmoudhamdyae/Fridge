import 'package:dartz/dartz.dart';
import 'package:fridge/core/error/failure.dart';
import 'package:fridge/expenses/domain/repository/expenses_repository.dart';

import '../../../core/error/exceptions.dart';

class ExpensesRepositoryImpl extends ExpensesRepository {
  ExpensesRepositoryImpl(super.remoteDataSource);

  @override
  Future<Either<Failure, void>> storeExpenses(String title, String date, String description, String amount) async {
    try {
      await remoteDataSource.storeExpenses(title, date, description, amount);
      return const Right(null);
    } on ServerException catch(failure) {
      return Left(ServerFailure(failure.errorMessageModel.message));
    }
  }

}