import 'package:equatable/equatable.dart';

class Analysis extends Equatable {
  final String? date;
  final String? product;
  final String? unit;
  final num? quantity;
  final num? totalWeight;
  final num? priceUnit;
  final num? totalPrice;
  final String? boxingType;

  const Analysis({
    required this.date,
    required this.product,
    required this.unit,
    required this.quantity,
    required this.totalWeight,
    required this.priceUnit,
    required this.totalPrice,
    required this.boxingType
  });

  @override
  List<Object?> get props => [
    date,
    product,
    unit,
    quantity,
    totalWeight,
    priceUnit,
    totalPrice,
    boxingType
  ];
}