import 'package:equatable/equatable.dart';

class ExpensesResponse extends Equatable {
  final int? id;
  final String? title;
  final int? expenseTypeId;
  final String? date;
  final String? description;
  final String? amount;

  const ExpensesResponse({
    required this.id,
    required this.title,
    required this.expenseTypeId,
    required this.date,
    required this.description,
    required this.amount
  });

  @override
  List<Object?> get props => [
    id,
    title,
    date,
    description,
    amount
  ];
}