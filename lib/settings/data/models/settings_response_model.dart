import 'package:fridge/settings/domain/entities/settings_response.dart';

class SettingsResponseModel extends SettingsResponse {

  const SettingsResponseModel({super.status, super.data});

  factory SettingsResponseModel.fromJson(Map<String, dynamic> json) => SettingsResponseModel(
    status: json['status'],
    data: json['data'] != null ? DataModel.fromJson(json['data']) : null,
  );
}

class DataModel extends Data {
  const DataModel({super.products, super.units, super.boxing, super.price, super.partsCount, super.smallBags, super.largeBags});

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
    products: json['products'],
    units: json['units'],
    boxing: json['boxing'],
    price: json['price'],
    partsCount: json['parts_count'],
    smallBags: json['small_bags'],
    largeBags: json['large_bags'],
  );
}