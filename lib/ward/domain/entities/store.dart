import 'package:equatable/equatable.dart';

class Store extends Equatable {
  final int? id;
  final int? fridgeId;
  final int? fridgePartId;
  final int? customerId;
  final String? product;
  final String? boxing;
  final String? unit;
  final int? quantity;
  final int? totalWeight;
  final int? price;
  final int? x;
  final int? y;
  final StoreCustomer? customer;

  const Store({
    required this.id,
    required this.fridgeId,
    required this.fridgePartId,
    required this.customerId,
    required this.product,
    required this.boxing,
    required this.unit,
    required this.quantity,
    required this.totalWeight,
    required this.price,
    required this.x,
    required this.y,
    required this.customer
  });

  @override
  List<Object?> get props => [
    id,
    fridgeId,
    fridgePartId,
    customerId,
    product,
    boxing,
    unit,
    quantity,
    totalWeight,
    price,
    x,
    y,
    customer,
  ];
}

class StoreCustomer extends Equatable {
  final int? id;
  final String? name;
  final String? phone;
  final String? address;
  final int? type;
  final int? fridgeId;

  const StoreCustomer({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.type,
    required this.fridgeId
  });

  @override
  List<Object?> get props => [id, name, phone, address, type, fridgeId];
}