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
  int? totalIncome;
  int? totalExpense;
  int? amountPaid;
  int? amountRemain;
  num? ton;
  int? bags;

  Year({
    this.chart,
    this.totalIncome,
    this.totalExpense,
    this.amountPaid,
    this.amountRemain,
    this.ton,
    this.bags,
  });

  Year.fromJson(Map<String, dynamic> json) {
    if (json['chart'] != null) {
      chart = <YearChart>[];
      json['chart'].forEach((v) {
        chart!.add(YearChart.fromJson(v));
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