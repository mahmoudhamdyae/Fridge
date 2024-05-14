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
  int? x;
  int? y;
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
    required this.x,
    required this.y,
    required this.bagType,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'type': type,
      'product': productType,
      'boxing': packagingType,
      'fridge_part_id': wardId,
      'quantity': number,
      'unit_weight': unitWeight,
      'total_weight': totalWeight,
      'price': price,
      'amount_paid': paid,
      'x_axies': x,
      'y_axies': y,
      'bag_type': bagType,
    };
  }
}