import 'package:equatable/equatable.dart';

class InvoiceResponse extends Equatable {
  final bool? status;
  final Invoice? data;

  const InvoiceResponse({required this.status, required this.data});

  factory InvoiceResponse.fromJson(Map<String, dynamic> json) => InvoiceResponse(
    status: json['status'],
    data: json['data'] != null ? Invoice.fromJson(json['data']) : null,
  );

  @override
  List<Object?> get props => [status, data];
}

class Invoice extends Equatable {
  final InvoiceCustomer? customer;
  final InvoiceStore? store;

  const Invoice({this.customer, this.store});

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
    customer: json['customer'] != null
        ? InvoiceCustomer.fromJson(json['customer'])
        : null,
    store: json['store'] != null ? InvoiceStore.fromJson(json['store']) : null,
  );

  @override
  List<Object?> get props => [customer, store];
}

class InvoiceCustomer extends Equatable {
  final String name;
  final String type;

  const InvoiceCustomer({required this.name, required this.type});

  factory InvoiceCustomer.fromJson(Map<String, dynamic> json) => InvoiceCustomer(
      name: json['name'],
      type: json['type']
  );

  @override
  List<Object> get props => [name, type];
}

class InvoiceStore extends Equatable {
  final String product;
  final String unit;
  final int quantity;
  final int totalWeight;
  final int priceUnit;
  final int totalPrice;
  final String boxingType;

  const InvoiceStore(
      {required this.product,
        required this.unit,
        required this.quantity,
        required this.totalWeight,
        required this.priceUnit,
        required this.totalPrice,
        required this.boxingType});

  factory InvoiceStore.fromJson(Map<String, dynamic> json) => InvoiceStore(
    product: json['product'],
    unit: json['unit'],
    quantity: json['quantity'],
    totalWeight: json['total_weight'],
    priceUnit: json['price_unit'],
    totalPrice: json['total_price'],
    boxingType: json['boxing_type'],
  );

  @override
  List<Object> get props => [product, unit, quantity, totalWeight, priceUnit, totalPrice, boxingType];
}