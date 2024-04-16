part of 'expenses_bloc.dart';

@immutable
class ExpensesState extends Equatable {
  final List<ExpenseType> types;
  const ExpensesState({this.types = const []});
  @override
  List<Object?> get props => [types];
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
  const GetExpensesLoadedState({required this.expenses, required super.types});
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

/// Store Expense Type

class StoreExpenseTypeLoadingState extends ExpensesState {
  const StoreExpenseTypeLoadingState();
}

class StoreExpenseTypeErrorState extends ExpensesState {
  final String errorMessage;
  const StoreExpenseTypeErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class StoreExpenseTypeSuccessState extends ExpensesState {
  const StoreExpenseTypeSuccessState();
}

/// Del Expense Type

class DelExpenseTypeLoadingState extends ExpensesState {
  const DelExpenseTypeLoadingState();
}

class DelExpenseTypeErrorState extends ExpensesState {
  final String errorMessage;
  const DelExpenseTypeErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class DelExpenseTypeSuccessState extends ExpensesState {
  const DelExpenseTypeSuccessState();
}
