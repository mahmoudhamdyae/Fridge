import 'package:equatable/equatable.dart';

class Client extends Equatable {
  final int? id;
  final String? name;
  final String? phone;
  final String? address;
  final int? type;
  final int? fridgeId;
  final int? amountPaid;
  final int? amountRemain;
  final num? tons;
  final int? bags;

  const Client({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.type,
    required this.fridgeId,
    required this.amountPaid,
    required this.amountRemain,
    required this.tons,
    required this.bags,
  });

  @override
  List<Object?> get props => [id, name, phone, address, type, fridgeId, amountPaid, amountRemain, tons, bags];
}