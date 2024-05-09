import 'package:dartz/dartz.dart';
import 'package:fridge/core/error/failure.dart';
import 'package:fridge/expenses/data/data_source/expenses_remote_data_source.dart';
import 'package:fridge/expenses/domain/entities/expenses_response.dart';

import '../entities/expense_type.dart';

abstract class ExpensesRepository {
  final ExpensesRemoteDataSource remoteDataSource;
  ExpensesRepository(this.remoteDataSource);

  Future<Either<Failure, void>> storeExpenses(int expenseTypeId, String description, String amount);
  Future<Either<Failure, List<ExpensesResponse>>> getExpenses();
  Future<Either<Failure, void>> delExpense(int expenseId);
  Future<Either<Failure, void>> editExpense(String expenseId, String title, String date, String description, String amount);
  Future<Either<Failure, List<ExpenseType>>> getExpenseTypes();
  Future<Either<Failure, void>> storeExpenseType(String typeName);
  Future<Either<Failure, void>> delExpenseType(int typeId);
}