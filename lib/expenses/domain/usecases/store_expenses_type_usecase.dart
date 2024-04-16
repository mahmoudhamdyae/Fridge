import 'package:dartz/dartz.dart';
import 'package:fridge/core/error/failure.dart';
import 'package:fridge/expenses/domain/repository/expenses_repository.dart';

class StoreExpensesTypeUsecase {
  final ExpensesRepository repository;
  StoreExpensesTypeUsecase(this.repository);

  Future<Either<Failure, void>> call(String typeName) async {
    return await repository.storeExpenseType(typeName);
  }
}