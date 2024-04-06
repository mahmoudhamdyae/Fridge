import 'package:dartz/dartz.dart';
import 'package:fridge/core/error/failure.dart';
import 'package:fridge/expenses/domain/entities/expenses_response.dart';
import 'package:fridge/expenses/domain/repository/expenses_repository.dart';

class GetExpensesUsecase {
  final ExpensesRepository repository;
  GetExpensesUsecase(this.repository);

  Future<Either<Failure, List<ExpensesResponse>>> call() async {
    return await repository.getExpenses();
  }
}