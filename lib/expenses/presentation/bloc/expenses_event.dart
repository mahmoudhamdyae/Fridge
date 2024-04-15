part of 'expenses_bloc.dart';

@immutable
abstract class ExpensesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetExpensesEvent extends ExpensesEvent {}

class StoreExpensesEvent extends ExpensesEvent {
  final int expenseTypeId;
  final String description;
  final String amount;

  StoreExpensesEvent(this.expenseTypeId, this.description, this.amount);

  @override
  List<Object> get props => [expenseTypeId, description, amount];
}
