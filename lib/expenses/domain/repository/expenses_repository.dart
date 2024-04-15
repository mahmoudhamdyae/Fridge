import 'package:dartz/dartz.dart';
import 'package:fridge/core/error/failure.dart';
import 'package:fridge/expenses/data/data_source/expenses_remote_data_source.dart';
import 'package:fridge/expenses/domain/entities/expenses_response.dart';

import '../entities/expense_type.dart';

abstract class ExpensesRepository {
  final ExpensesRemoteDataSource remoteDataSource;
  ExpensesRepository(this.remoteDataSource);

  Future<Either<Failure, void>> storeExpenses(String title, String date, String description, String amount);
  Future<Either<Failure, List<ExpensesResponse>>> getExpenses();
  Future<Either<Failure, List<ExpenseType>>> getExpenseTypes();
}