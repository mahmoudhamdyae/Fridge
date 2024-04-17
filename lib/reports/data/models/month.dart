class MonthResponse {
  bool? status;
  Month? data;

  MonthResponse({this.status, this.data});

  MonthResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Month.fromJson(json['data']) : null;
  }
}

class Month {
  List<MonthChart>? chart;
  int? totalIncome;
  String? totalExpense;

  Month({this.chart, this.totalIncome, this.totalExpense});

  Month.fromJson(Map<String, dynamic> json) {
    if (json['chart'] != null) {
      chart = <MonthChart>[];
      json['chart'].forEach((v) {
        chart!.add(MonthChart.fromJson(v));
      });
    }
    totalIncome = json['totalIncome'];
    totalExpense = json['totalExpense'];
  }
}

class MonthChart {
  String? date;
  String? day;
  int? count;

  MonthChart({this.date, this.day, this.count});

  MonthChart.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'];
    count = json['count'];
  }
}