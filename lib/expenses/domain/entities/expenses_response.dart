import 'package:equatable/equatable.dart';

class ExpensesResponse extends Equatable {
  final int? id;
  final String? title;
  final String? date;
  final String? description;
  final String? amount;

  const ExpensesResponse({
    required this.id,
    required this.title,
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