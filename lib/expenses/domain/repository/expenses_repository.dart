import 'package:dartz/dartz.dart';
import 'package:fridge/core/error/failure.dart';
import 'package:fridge/expenses/data/data_source/expenses_remote_data_source.dart';

abstract class ExpensesRepository {
  final ExpensesRemoteDataSource remoteDataSource;
  ExpensesRepository(this.remoteDataSource);

  Future<Either<Failure, void>> storeExpenses(String title, String date, String description, String amount);
}