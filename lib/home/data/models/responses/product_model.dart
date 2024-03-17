import 'package:fridge/home/domain/entities/product.dart';

class ProductModel extends Product {

  ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.fridgeId
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      fridgeId: json['fridge_id']
  );
}