part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetProducts extends HomeEvent {}

class StoreProduct extends HomeEvent {
  final String name;
  final String description;
  StoreProduct(this.name, this.description);

  @override
  List<Object?> get props => [name, description];
}

class UpdateProduct extends HomeEvent {
  final int id;
  final String name;
  final String description;
  UpdateProduct(this.id, this.name, this.description);

  @override
  List<Object?> get props => [id, name, description];
}

class DelProduct extends HomeEvent {
  final int productId;
  DelProduct(this.productId);

  @override
  List<Object?> get props => [productId];
}