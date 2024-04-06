import 'package:dartz/dartz.dart';
import 'package:fridge/core/error/failure.dart';
import 'package:fridge/expenses/domain/repository/expenses_repository.dart';

class StoreExpensesUsecase {
  final ExpensesRepository repository;
  StoreExpensesUsecase(this.repository);

  Future<Either<Failure, void>> call(String title, String date, String description, String amount) async {
    return await repository.storeExpenses(title, date, description, amount);
  }
}