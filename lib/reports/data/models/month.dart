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
  int? totalExpense;
  int? amountPaid;
  int? amountRemain;
  num? ton;
  int? bags;

  Month({
    this.chart,
    this.totalIncome,
    this.totalExpense,
    this.amountPaid,
    this.amountRemain,
    this.ton,
    this.bags,
  });

  Month.fromJson(Map<String, dynamic> json) {
    if (json['chart'] != null) {
      chart = <MonthChart>[];
      json['chart'].forEach((v) {
        chart!.add(MonthChart.fromJson(v));
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