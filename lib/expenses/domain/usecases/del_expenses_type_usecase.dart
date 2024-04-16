import 'package:dartz/dartz.dart';
import 'package:fridge/core/error/failure.dart';
import 'package:fridge/expenses/domain/repository/expenses_repository.dart';

class DelExpensesTypeUsecase {
  final ExpensesRepository repository;
  DelExpensesTypeUsecase(this.repository);

  Future<Either<Failure, void>> call(int typeId) async {
    return await repository.delExpenseType(typeId);
  }
}