import 'package:dartz/dartz.dart';
import 'package:fridge/core/error/failure.dart';
import 'package:fridge/expenses/domain/repository/expenses_repository.dart';

class EditExpensesUsecase {
  final ExpensesRepository repository;
  EditExpensesUsecase(this.repository);

  Future<Either<Failure, void>> call(String expenseId, int expenseTypeId, String description, String amount) async {
    return await repository.editExpense(expenseId, expenseTypeId, description, amount);
  }
}