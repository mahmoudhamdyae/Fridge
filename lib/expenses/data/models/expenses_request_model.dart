import 'package:fridge/expenses/domain/entities/expenses_request.dart';

class ExpensesRequestModel extends ExpensesRequest {

  const ExpensesRequestModel({
    required super.expenseTypeId,
    required super.description,
    required super.amount
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['expense_type_id'] = expenseTypeId;
    data['description'] = description;
    data['amount'] = amount;
    return data;
  }
}