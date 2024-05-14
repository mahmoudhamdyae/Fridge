import 'package:equatable/equatable.dart';

class ProductToAdd extends Equatable {
  final String? productType;
  final String? packagingType;
  final int? number;
  final double? unitWeight;
  final double? totalWeight;
  final double? price;
  final double? paid;
  final String? bagType;

  const ProductToAdd({
    this.productType,
    this.packagingType,
    this.number,
    this.unitWeight,
    this.totalWeight,
    this.price,
    this.paid,
    this.bagType,
  });

  @override
  List<Object?> get props => [
    productType,
    packagingType,
    number,
    unitWeight,
    totalWeight,
    price,
    paid,
    bagType
  ];
}