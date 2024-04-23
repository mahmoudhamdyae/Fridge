class WeekResponse {
  bool? status;
  Week? data;

  WeekResponse({this.status, this.data});

  WeekResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Week.fromJson(json['data']) : null;
  }
}

class Week {
  List<WeekChart>? chart;
  dynamic totalIncome;
  dynamic totalExpense;

  Week({this.chart, this.totalIncome, this.totalExpense});

  Week.fromJson(Map<String, dynamic> json) {
    if (json['chart'] != null) {
      chart = <WeekChart>[];
      json['chart'].forEach((v) {
        chart!.add(WeekChart.fromJson(v));
      });
    }
    totalIncome = json['totalIncome'];
    totalExpense = json['totalExpense'];
  }
}

class WeekChart {
  String? date;
  String? day;
  int? count;

  WeekChart({this.date, this.day, this.count});

  WeekChart.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'];
    count = json['count'];
  }
}