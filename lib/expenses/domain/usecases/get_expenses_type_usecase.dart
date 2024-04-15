import 'package:dartz/dartz.dart';
import 'package:fridge/core/error/failure.dart';
import 'package:fridge/expenses/domain/entities/expense_type.dart';
import 'package:fridge/expenses/domain/repository/expenses_repository.dart';

class GetExpensesTypeUsecase {
  final ExpensesRepository repository;
  GetExpensesTypeUsecase(this.repository);

  Future<Either<Failure, List<ExpenseType>>> call() async {
    return await repository.getExpenseTypes();
  }
}