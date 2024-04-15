part of 'clients_bloc.dart';

abstract class ClientsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetClientsEvent extends ClientsEvent {}

class AddClientEvent extends ClientsEvent {
  final bool isTrader;
  final String clientName;
  final String clientPhone;
  final String? clientAddress;
  AddClientEvent(this.isTrader, this.clientName, this.clientPhone, this.clientAddress);
  @override
  List<Object?> get props => [isTrader, clientName, clientPhone, clientAddress];
}

class AddProductEvent extends ClientsEvent {
  final String productType;
  final String packagingType;
  final int number;
  final int unitWeight;
  final int totalWeight;
  final double price;
  AddProductEvent(this.productType, this.packagingType, this.number, this.unitWeight, this.totalWeight, this.price);
  @override
  List<Object?> get props => [productType, packagingType, number, unitWeight, totalWeight, price];
}

class ChooseWardEvent extends ClientsEvent {
  final Ward ward;
  ChooseWardEvent(this.ward);
  @override
  List<Object?> get props => [ward];
}

class ChoosePlaceEvent extends ClientsEvent {
  final int x;
  final int y;
  ChoosePlaceEvent(this.x, this.y);
  @override
  List<Object?> get props => [x, y];
}

class FinishEvent extends ClientsEvent {
  final int x;
  final int y;
  FinishEvent(this.x, this.y);
  @override
  List<Object?> get props => [x, y];
}
