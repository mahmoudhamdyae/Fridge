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
  int? totalIncome;
  int? totalExpense;
  int? amountPaid;
  int? amountRemain;
  num? ton;
  int? bags;

  Week({
    this.chart,
    this.totalIncome,
    this.totalExpense,
    this.amountPaid,
    this.amountRemain,
    this.ton,
    this.bags,
  });

  Week.fromJson(Map<String, dynamic> json) {
    if (json['chart'] != null) {
      chart = <WeekChart>[];
      json['chart'].forEach((v) {
        chart!.add(WeekChart.fromJson(v));
      });
    }
    totalIncome = json['total_price'];
    totalExpense = json['totalExpense'];
    amountPaid = json['amount_paid'];
    amountRemain = json['amount_remain'];
    ton = json['tons'];
    bags = json['bags'];
  }
}

class WeekChart {
  String? date;
  String? day;
  num? count;

  WeekChart({this.date, this.day, this.count});

  WeekChart.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'];
    count = json['count'];
  }
}