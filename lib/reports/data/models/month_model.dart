import 'package:fridge/reports/domain/entities/month.dart';

class MonthResponse {
  bool? status;
  List<MonthModel>? data;

  MonthResponse({this.status, this.data});

  MonthResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <MonthModel>[];
      json['data'].forEach((v) {
        data!.add(MonthModel.fromJson(v));
      });
    }
  }
}

class MonthModel extends Month {

  const MonthModel({
    super.date,
    super.day,
    super.count
  });

  factory MonthModel.fromJson(Map<String, dynamic> json) => MonthModel(
    date: json['date'],
    day: json['day'],
    count: json['count'],
  );
}