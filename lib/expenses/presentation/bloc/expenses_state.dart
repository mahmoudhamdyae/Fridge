part of 'expenses_bloc.dart';

@immutable
class ExpensesState extends Equatable {
  final RequestState getExpensesState;
  final String getExpensesErrorMessage;
  final List<ExpensesResponse> expenses;
  final RequestState storeExpensesState;
  final String storeExpensesErrorMessage;

  const ExpensesState({
    this.getExpensesState = RequestState.loading,
    this.getExpensesErrorMessage = '',
    this.expenses = const [],
    this.storeExpensesState = RequestState.init,
    this.storeExpensesErrorMessage = '',
  });

  ExpensesState copyWith({
    RequestState? getExpensesState,
    String? getExpensesErrorMessage,
    List<ExpensesResponse>? expenses,
    RequestState? storeExpensesState,
    String? storeExpensesErrorMessage,
  }) {
    return ExpensesState(
      getExpensesState: getExpensesState?? this.getExpensesState,
      getExpensesErrorMessage: getExpensesErrorMessage?? this.getExpensesErrorMessage,
      expenses: expenses ?? this.expenses,
      storeExpensesState: storeExpensesState?? this.storeExpensesState,
      storeExpensesErrorMessage: storeExpensesErrorMessage?? this.storeExpensesErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    getExpensesState,
    getExpensesErrorMessage,
    expenses,
    storeExpensesState,
    storeExpensesErrorMessage,
  ];
}
