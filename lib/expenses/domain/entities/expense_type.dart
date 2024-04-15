import 'package:equatable/equatable.dart';

class ExpenseType extends Equatable {
  final int? id;
  final String? name;
  final int? fridgeId;

  const ExpenseType({
    required this.id,
    required this.name,
    required this.fridgeId,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    fridgeId,
  ];
}