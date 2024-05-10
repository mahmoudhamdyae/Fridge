import '../../domain/entities/expenses_response.dart';

class ExpensesResponsesFullResponse {
  bool? status;
  List<ExpensesResponseModel>? data;

  ExpensesResponsesFullResponse({this.status, this.data});

  ExpensesResponsesFullResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ExpensesResponseModel>[];
      json['data'].forEach((v) {
        data!.add(ExpensesResponseModel.fromJson(v));
      });
    }
  }
}

class ExpensesResponseModel extends ExpensesResponse {
  const ExpensesResponseModel({
    super.id,
    super.title,
    super.expenseTypeId,
    super.date,
    super.description,
    super.amount
  });

  factory ExpensesResponseModel.fromJson(Map<String, dynamic> json) => ExpensesResponseModel(
    id: json['id'],
    title: json['expense_type']['name'],
    expenseTypeId: json['expense_type']['id'],
    date: json['date'],
    description: json['description'],
    amount: json['amount'],
  );
}