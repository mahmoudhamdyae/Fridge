import '../../domain/entities/client.dart';

class Clients {
  bool? status;
  List<ClientModel>? data;

  Clients({this.status, this.data});

  Clients.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ClientModel>[];
      json['data'].forEach((v) {
        data!.add(ClientModel.fromJson(v));
      });
    }
  }
}

class ClientModel extends Client {

  const ClientModel({
    required super.id,
    required super.name,
    required super.phone,
    required super.address,
    required super.type,
    required super.fridgeId,
    required super.amountPaid,
    required super.amountRemain,
    required super.tons,
    required super.bags
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
    id: json['id'],
    name: json['name'],
    phone: json['phone'],
    address: json['address'],
    type: json['type'],
    fridgeId: json['fridge_id'],
    amountPaid: json['amount_paid'],
    amountRemain: json['amount_remain'],
    tons: json['tons'],
    bags: json['bags'],
  );
}