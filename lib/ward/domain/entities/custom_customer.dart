import 'package:equatable/equatable.dart';

class CustomCustomer extends Equatable {
  final String? name;
  final String? type;
  final String? product;
  final String? quantity;
  final int storeId;

  const CustomCustomer({
    required this.name,
    required this.type,
    required this.product,
    required this.quantity,
    required this.storeId,
  });

  @override
  List<Object?> get props => [
    name,
    type,
    product,
    quantity,
    storeId,
  ];
}