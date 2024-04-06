import '../../domain/entities/expenses_response.dart';

class EResponse {
  bool? status;
  List<ExpensesResponseModel>? data;

  EResponse({this.status, this.data});

  EResponse.fromJson(Map<String, dynamic> json) {
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
    super.date,
    super.description,
    super.amount
  });

  factory ExpensesResponseModel.fromJson(Map<String, dynamic> json) => ExpensesResponseModel(
    id: json['id'],
    title: json['title'],
    date: json['date'],
    description: json['description'],
    amount: json['amount'],
  );
}