import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final String description;
  final int fridgeId;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.fridgeId,
  });

  @override
  List<Object> get props => [id, name, description, fridgeId];
}