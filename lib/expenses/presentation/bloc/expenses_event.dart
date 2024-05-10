part of 'expenses_bloc.dart';

@immutable
abstract class ExpensesEvent extends Equatable {
  const ExpensesEvent();
  @override
  List<Object> get props => [];
}

class GetExpensesEvent extends ExpensesEvent {}
class GetExpensesTypesEvent extends ExpensesEvent {}

class StoreExpensesEvent extends ExpensesEvent {
  final int expenseTypeId;
  final String description;
  final String amount;

  const StoreExpensesEvent(this.expenseTypeId, this.description, this.amount);

  @override
  List<Object> get props => [expenseTypeId, description, amount];
}

/// Del Expense

class DelExpenseEvent extends ExpensesEvent {
  final int expenseId;
  const DelExpenseEvent(this.expenseId);
  @override
  List<Object> get props => [expenseId];
}

/// Edit Expense

class EditExpenseEvent extends ExpensesEvent {
  final String expenseId;
  final int expenseTypeId;
  final String description;
  final String amount;
  const EditExpenseEvent(this.expenseId, this.expenseTypeId, this.description, this.amount);
  @override
  List<Object> get props => [expenseId, expenseTypeId, description, amount];
}

/// Store Expense Type

class StoreExpenseTypeEvent extends ExpensesEvent {
  final String typeName;
  const StoreExpenseTypeEvent(this.typeName);
  @override
  List<Object> get props => [typeName];
}

/// Del Expense Type

class DelExpenseTypeEvent extends ExpensesEvent {
  final int typeId;
  const DelExpenseTypeEvent(this.typeId);
  @override
  List<Object> get props => [typeId];
}
