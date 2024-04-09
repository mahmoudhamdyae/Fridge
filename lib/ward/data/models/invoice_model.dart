import 'package:equatable/equatable.dart';
import 'package:fridge/ward/domain/entities/invoice.dart';

class InvoiceResponse extends Equatable {
  final bool? status;
  final InvoiceModel? data;

  const InvoiceResponse({this.status, this.data});

  factory InvoiceResponse.fromJson(Map<String, dynamic> json) => InvoiceResponse(
    status: json['status'],
    data: json['data'] != null ? InvoiceModel.fromJson(json['data']) : null,
  );

  @override
  List<Object?> get props => [status, data];
}

class InvoiceModel extends Invoice {

  const InvoiceModel({super.customer, super.store});

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
    customer: json['customer'] != null
        ? InvoiceCustomerModel.fromJson(json['customer'])
        : null,
    store: json['store'] != null ? InvoiceStoreModel.fromJson(json['store']) : null,
  );
}

class InvoiceCustomerModel extends InvoiceCustomer {

  const InvoiceCustomerModel({super.name, super.type});

  factory InvoiceCustomerModel.fromJson(Map<String, dynamic> json) => InvoiceCustomerModel(
      name: json['name'],
      type: json['type']
  );
}

class InvoiceStoreModel extends InvoiceStore {
  const InvoiceStoreModel({
    super.product,
    super.unit,
    super.quantity,
    super.totalWeight,
    super.priceUnit,
    super.totalPrice,
    super.boxingType
  });

  factory InvoiceStoreModel.fromJson(Map<String, dynamic> json) => InvoiceStoreModel(
    product: json['product'],
    unit: json['unit'],
    quantity: json['quantity'],
    totalWeight: json['total_weight'],
    priceUnit: json['price_unit'],
    totalPrice: json['total_price'],
    boxingType: json['boxing_type'],
  );
}