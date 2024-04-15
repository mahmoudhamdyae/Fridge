import '../../domain/entities/expense_type.dart';

class ExpenseTypeResponse {
  bool? status;
  List<ExpenseTypeModel>? data;

  ExpenseTypeResponse({this.status, this.data});

  ExpenseTypeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ExpenseTypeModel>[];
      json['data'].forEach((v) {
        data!.add(ExpenseTypeModel.fromJson(v));
      });
    }
  }
}

class ExpenseTypeModel extends ExpenseType {

  const ExpenseTypeModel({super.id, super.name, super.fridgeId});

  factory ExpenseTypeModel.fromJson(Map<String, dynamic> json) => ExpenseTypeModel(
    id: json['id'],
    name: json['name'],
    fridgeId: json['fridge_id'],
  );
}