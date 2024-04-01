class SettingsRequest {
  List<String>? products;
  List<String>? boxing;
  String? units;
  int? price;
  int? partsCount;

  SettingsRequest(
      {this.products, this.boxing, this.units, this.price, this.partsCount});

  SettingsRequest.fromJson(Map<String, dynamic> json) {
    products = json['products'].cast<String>();
    boxing = json['boxing'].cast<String>();
    units = json['units'];
    price = json['price'];
    partsCount = json['parts_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['products'] = products;
    data['boxing'] = boxing;
    data['units'] = units;
    data['price'] = price;
    data['parts_count'] = partsCount;
    return data;
  }
}