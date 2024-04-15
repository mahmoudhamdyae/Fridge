import 'package:equatable/equatable.dart';

class ExpensesRequest extends Equatable {
  final int? expenseTypeId;
  final String? description;
  final String? amount;

  const ExpensesRequest({
    required this.expenseTypeId,
    required this.description,
    required this.amount
  });

  @override
  List<Object?> get props => [expenseTypeId, description, amount];
}