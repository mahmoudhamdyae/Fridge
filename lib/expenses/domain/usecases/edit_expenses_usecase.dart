import 'package:dartz/dartz.dart';
import 'package:fridge/core/error/failure.dart';
import 'package:fridge/expenses/domain/repository/expenses_repository.dart';

class EditExpensesUsecase {
  final ExpensesRepository repository;
  EditExpensesUsecase(this.repository);

  Future<Either<Failure, void>> call(String expenseId, String title, String date, String description, String amount) async {
    return await repository.editExpense(expenseId, title, date, description, amount);
  }
}