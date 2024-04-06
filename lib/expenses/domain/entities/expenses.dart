import 'package:equatable/equatable.dart';

class Expenses extends Equatable {
  final String? title;
  final String? date;
  final String? description;
  final String? amount;

  const Expenses({
    required this.title,
    required this.date,
    required this.description,
    required this.amount
  });

  @override
  List<Object?> get props => [title, date, description, amount];
}