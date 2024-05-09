import 'package:dartz/dartz.dart';
import 'package:fridge/core/error/failure.dart';
import 'package:fridge/expenses/domain/repository/expenses_repository.dart';

class DelExpenseUsecase {
  final ExpensesRepository repository;
  DelExpenseUsecase(this.repository);

  Future<Either<Failure, void>> call(int expenseId) async {
    return await repository.delExpense(expenseId);
  }
}