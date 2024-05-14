import 'package:fridge/clients/presentation/bloc/clients_bloc.dart';

class AddClientRequest {
  String? name;
  String? phone;
  String? address;
  int? type;
  String? productType;
  String? packagingType;
  int? wardId;
  int? number;
  double? unitWeight;
  double? totalWeight;
  double? price;
  double? paid;
  List<Position>? positions;
  String? bagType;

  AddClientRequest({
    required this.name,
    required this.phone,
    required this.address,
    required this.type,
    required this.productType,
    required this.packagingType,
    required this.wardId,
    required this.number,
    required this.unitWeight,
    required this.totalWeight,
    required this.price,
    required this.paid,
    required this.positions,
    required this.bagType,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (positions != null) {
      data['axies'] = positions!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    data['phone'] = phone;
    data['address'] = address;
    data['type'] = type;
    data['product'] = productType;
    data['boxing'] = packagingType;
    data['fridge_part_id'] = wardId;
    data['quantity'] = number;
    data['unit_weight'] = unitWeight;
    data['total_weight'] = totalWeight;
    data['price'] = price;
    data['amount_paid'] = paid;
    data['bag_type'] = bagType;
    return data;
  }
}