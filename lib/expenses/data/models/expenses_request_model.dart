import 'package:fridge/expenses/domain/entities/expenses_request.dart';

class ExpensesRequestModel extends ExpensesRequest {

  const ExpensesRequestModel({
    required super.title,
    required super.date,
    required super.description,
    required super.amount
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['date'] = date;
    data['description'] = description;
    data['amount'] = amount;
    return data;
  }
}