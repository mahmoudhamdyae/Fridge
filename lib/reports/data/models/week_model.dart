import 'package:fridge/reports/domain/entities/week.dart';

class WeekResponse {
  bool? status;
  List<WeekModel>? data;

  WeekResponse({this.status, this.data});

  WeekResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <WeekModel>[];
      json['data'].forEach((v) {
        data!.add(WeekModel.fromJson(v));
      });
    }
  }
}

class WeekModel extends Week {
  const WeekModel({
    super.date,
    super.day,
    super.count
  });

  factory WeekModel.fromJson(Map<String, dynamic> json) => WeekModel(
    date: json['date'],
    day: json['day'],
    count: json['count'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['day'] = day;
    data['count'] = count;
    return data;
  }
}