part of 'clients_bloc.dart';

abstract class ClientsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetClientsEvent extends ClientsEvent {}

class AddClientEvent extends ClientsEvent {
  final Bool isTrader;
  final String clientName;
  final String clientPhone;
  final String clientAddress;
  AddClientEvent(this.isTrader, this.clientName, this.clientPhone, this.clientAddress);
  @override
  List<Object?> get props => [isTrader, clientName, clientPhone, clientAddress];
}

class AddProductEvent extends ClientsEvent {
  final String productType;
  final String packagingType;
  final String unitWeight;
  final String totalWeight;
  final double price;
  AddProductEvent(this.productType, this.packagingType, this.unitWeight, this.totalWeight, this.price);
  @override
  List<Object?> get props => [productType, packagingType, unitWeight, totalWeight, price];
}

class ChooseWard extends ClientsEvent {
  final int wardNum;
  ChooseWard(this.wardNum);
  @override
  List<Object?> get props => [wardNum];
}
