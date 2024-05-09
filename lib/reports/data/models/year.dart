class YearResponse {
  bool? status;
  Year? data;

  YearResponse({this.status, this.data});

  YearResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Year.fromJson(json['data']) : null;
  }
}

class Year {
  List<YearChart>? chart;
  dynamic totalIncome;
  dynamic totalExpense;

  Year({this.chart, this.totalIncome, this.totalExpense});

  Year.fromJson(Map<String, dynamic> json) {
    if (json['chart'] != null) {
      chart = <YearChart>[];
      json['chart'].forEach((v) {
        chart!.add(YearChart.fromJson(v));
      });
    }
    totalIncome = json['totalIncome'];
    totalExpense = json['totalExpense'];
  }
}

class YearChart {
  String? date;
  String? month;
  int? count;

  YearChart({this.date, this.month, this.count});

  YearChart.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    month = json['day'];
    count = json['count'];
  }
}