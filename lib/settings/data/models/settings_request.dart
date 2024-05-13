class SettingsRequest {
  List<String>? products;
  List<String>? boxing;
  String? units;
  double? price;
  int? partsCount;
  double? smallBags;
  double? largeBags;

  SettingsRequest(
      {this.products, this.boxing, this.units, this.price, this.partsCount, this.smallBags, this.largeBags});

  SettingsRequest.fromJson(Map<String, dynamic> json) {
    products = json['products'].cast<String>();
    boxing = json['boxing'].cast<String>();
    units = json['units'];
    price = json['price'];
    partsCount = json['parts_count'];
    smallBags = json['small_bags'];
    largeBags = json['large_bags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['products'] = products;
    data['boxing'] = boxing;
    data['units'] = units;
    data['price'] = price;
    data['parts_count'] = partsCount;
    data['small_bags'] = smallBags;
    data['large_bags'] = largeBags;
    return data;
  }
}