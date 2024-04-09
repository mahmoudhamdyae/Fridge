import 'package:equatable/equatable.dart';

class Invoice extends Equatable {
  final InvoiceCustomer? customer;
  final InvoiceStore? store;

  const Invoice({this.customer, this.store});

  @override
  List<Object?> get props => [customer, store];
}

class InvoiceCustomer extends Equatable {
  final String? name;
  final String? type;

  const InvoiceCustomer({required this.name, required this.type});

  @override
  List<Object?> get props => [name, type];
}

class InvoiceStore extends Equatable {
  final String? product;
  final String? unit;
  final int? quantity;
  final int? totalWeight;
  final int? priceUnit;
  final int? totalPrice;
  final String? boxingType;

  const InvoiceStore({
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
    product,
    unit,
    quantity,
    totalWeight,
    priceUnit,
    totalPrice,
    boxingType
  ];
}