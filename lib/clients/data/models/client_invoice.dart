import 'package:equatable/equatable.dart';

class ClientInvoiceResponse {
  bool? status;
  ClientInvoiceData? data;

  ClientInvoiceResponse({this.status, this.data});

  ClientInvoiceResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? ClientInvoiceData.fromJson(json['data']) : null;
  }
}

class ClientInvoiceData extends Equatable {
  final int? id;
  final String? name;
  final String? phone;
  final String? address;
  final int? type;
  final int? fridgeId;
  final int? amountPaid;
  final int? amountRemain;
  final List<ClientInvoiceStores>? stores;

  const ClientInvoiceData({
    this.id,
    this.name,
    this.phone,
    this.address,
    this.type,
    this.fridgeId,
    this.amountPaid,
    this.amountRemain,
    this.stores
  });

  factory ClientInvoiceData.fromJson(Map<String, dynamic> json) {
    List<ClientInvoiceStores> stores = [];
    if (json['stores'] != null) {
      json['stores'].forEach((v) {
        stores.add(ClientInvoiceStores.fromJson(v));
      });
    }
    return ClientInvoiceData(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        address: json['address'],
        type: json['type'],
        fridgeId: json['fridge_id'],
        amountPaid: json['amount_paid'],
        amountRemain: json['amount_remain'],
        stores: stores
    );
  }

  @override
  List<Object?> get props => [id, name, phone, address, type, fridgeId,amountPaid, amountRemain, stores];
}

class ClientInvoiceStores {
  int? id;
  int? fridgeId;
  int? fridgePartId;
  int? customerId;
  String? product;
  String? boxing;
  String? unit;
  num? quantity;
  String? totalWeight;
  num? price;
  num? totalBagPrice;
  int? xAxies;
  int? yAxies;
  String? partName;
  num? paid;

  ClientInvoiceStores(
      {this.id,
        this.fridgeId,
        this.fridgePartId,
        this.customerId,
        this.product,
        this.boxing,
        this.unit,
        this.quantity,
        this.totalWeight,
        this.price,
        this.totalBagPrice,
        this.xAxies,
        this.yAxies,
        this.partName,
        this.paid});

  ClientInvoiceStores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fridgeId = json['fridge_id'];
    fridgePartId = json['fridge_part_id'];
    customerId = json['customer_id'];
    product = json['product'];
    boxing = json['boxing'];
    unit = json['unit'];
    quantity = json['quantity'];
    totalWeight = json['total_weight'];
    price = json['price'];
    totalBagPrice = json['total_bag_price'];
    xAxies = json['x_axies'];
    yAxies = json['y_axies'];
    partName = json['part_name'];
    paid = json['amount_paid'];
  }
}