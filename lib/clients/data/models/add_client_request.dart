class AddClientRequest {
  String? name;
  String? phone;
  String? address;
  int? type;
  String? productType;
  String? packagingType;
  int? wardId;
  int? number;
  int? unitWeight;
  int? totalWeight;
  double? price;
  int? x;
  int? y;


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
    required this.x,
    required this.y,
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
      'x_axies': x,
      'y_axies': y,
    };
  }
}