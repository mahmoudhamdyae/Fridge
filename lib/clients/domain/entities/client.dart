import 'package:equatable/equatable.dart';

class Client extends Equatable {
  final int? id;
  final String? name;
  final String? phone;
  final String? address;
  final int? type;
  final int? fridgeId;

  const Client({
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