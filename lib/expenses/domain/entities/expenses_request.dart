import 'package:equatable/equatable.dart';

class ExpensesRequest extends Equatable {
  final String? title;
  final String? date;
  final String? description;
  final String? amount;

  const ExpensesRequest({
    required this.title,
    required this.date,
    required this.description,
    required this.amount
  });

  @override
  List<Object?> get props => [title, date, description, amount];
}