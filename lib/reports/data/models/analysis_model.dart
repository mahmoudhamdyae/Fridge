import 'package:fridge/reports/domain/entities/analysis.dart';

class AnalysisResponse {
  bool? status;
  List<AnalysisModel>? data;

  AnalysisResponse({this.status, this.data});

  AnalysisResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(AnalysisModel.fromJson(v));
      });
    }
  }
}

class AnalysisModel extends Analysis {

  const AnalysisModel({
    super.date,
    super.product,
    super.unit,
    super.quantity,
    super.totalWeight,
    super.priceUnit,
    super.totalPrice,
    super.boxingType
  });

  factory AnalysisModel.fromJson(Map<String, dynamic> json) => AnalysisModel(
    date: json['date'],
    product: json['product'],
    unit: json['unit'],
    quantity: json['quantity'],
    totalWeight: json['total_weight'],
    priceUnit: json['price_unit'],
    totalPrice: json['total_price'],
    boxingType: json['boxing_type'],
  );
}