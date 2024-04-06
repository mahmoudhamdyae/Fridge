part of 'expenses_bloc.dart';

@immutable
class ExpensesState extends Equatable {
  final RequestState storeExpensesState;
  final String storeExpensesErrorMessage;

  const ExpensesState({
    this.storeExpensesState = RequestState.init,
    this.storeExpensesErrorMessage = '',
  });

  ExpensesState copyWith({
    RequestState? storeExpensesState,
    String? storeExpensesErrorMessage,
  }) {
    return ExpensesState(
      storeExpensesState: storeExpensesState?? this.storeExpensesState,
      storeExpensesErrorMessage: storeExpensesErrorMessage?? this.storeExpensesErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
        storeExpensesState,
        storeExpensesErrorMessage,
  ];
}
