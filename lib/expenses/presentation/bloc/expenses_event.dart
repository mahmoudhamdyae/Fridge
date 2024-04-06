part of 'expenses_bloc.dart';

@immutable
abstract class ExpensesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetExpensesEvent extends ExpensesEvent {}

class StoreExpensesEvent extends ExpensesEvent {
  final String title;
  final String date;
  final String description;
  final String amount;

  StoreExpensesEvent(this.title, this.date, this.description, this.amount);

  @override
  List<Object> get props => [title, date, description, amount];
}
