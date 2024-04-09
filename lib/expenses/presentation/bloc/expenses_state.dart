part of 'expenses_bloc.dart';

@immutable
class ExpensesState extends Equatable {
  const ExpensesState();
  @override
  List<Object?> get props => [];
}

/// Get Expenses

class GetExpensesLoadingState extends ExpensesState {
  const GetExpensesLoadingState();
}

class GetExpensesErrorState extends ExpensesState {
  final String errorMessage;
  const GetExpensesErrorState(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}

class GetExpensesLoadedState extends ExpensesState {
  final List<ExpensesResponse> expenses;
  const GetExpensesLoadedState(this.expenses);
  @override
  List<Object?> get props => [expenses];
}

/// Add Expense

class StoreExpenseLoadingState extends ExpensesState {}

class StoreExpenseErrorState extends ExpensesState {
  final String errorMessage;
  const StoreExpenseErrorState(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}

class StoreExpenseSuccessState extends ExpensesState {}
