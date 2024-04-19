import 'package:equatable/equatable.dart';

class ProductToAdd extends Equatable {
  final String? productType;
  final String? packagingType;
  final int? number;
  final int? unitWeight;
  final double? totalWeight;
  final double? price;

  const ProductToAdd({
    this.productType,
    this.packagingType,
    this.number,
    this.unitWeight,
    this.totalWeight,
    this.price,
  });

  @override
  List<Object?> get props => [
    productType,
    packagingType,
    number,
    unitWeight,
    totalWeight,
    price
  ];
}