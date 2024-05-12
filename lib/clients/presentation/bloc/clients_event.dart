part of 'clients_bloc.dart';

abstract class ClientsEvent extends Equatable {
  const ClientsEvent();
  @override
  List<Object?> get props => [];
}

class GetClientsEvent extends ClientsEvent {}

class SearchClientsEvent extends ClientsEvent {
  final String search;
  const SearchClientsEvent(this.search);
  @override
  List<Object?> get props => [search];
}

class AddClientEvent extends ClientsEvent {
  final bool isTrader;
  final String clientName;
  final String clientPhone;
  final String? clientAddress;
  const AddClientEvent(this.isTrader, this.clientName, this.clientPhone, this.clientAddress);
  @override
  List<Object?> get props => [isTrader, clientName, clientPhone, clientAddress];
}

class AddProductEvent extends ClientsEvent {
  final String productType;
  final String packagingType;
  final String number;
  final String unitWeight;
  final String totalWeight;
  final double price;
  final double paid;
  const AddProductEvent(
      this.productType,
      this.packagingType,
      this.number,
      this.unitWeight,
      this.totalWeight,
      this.price,
      this.paid,
      );
  @override
  List<Object?> get props => [productType, packagingType, number, unitWeight, totalWeight, price, paid];
}

class ChooseWardEvent extends ClientsEvent {
  final Ward ward;
  const ChooseWardEvent(this.ward);
  @override
  List<Object?> get props => [ward];
}

class ChoosePlaceEvent extends ClientsEvent {
  final int x;
  final int y;
  const ChoosePlaceEvent(this.x, this.y);
  @override
  List<Object?> get props => [x, y];
}

class FinishEvent extends ClientsEvent {
  final int x;
  final int y;
  const FinishEvent(this.x, this.y);
  @override
  List<Object?> get props => [x, y];
}

class GetClientInvoiceEvent extends ClientsEvent {
  final int clientId;
  const GetClientInvoiceEvent(this.clientId);
  @override
  List<Object?> get props => [clientId];
}

class DelClientEvent extends ClientsEvent {
  final int clientId;
  const DelClientEvent(this.clientId);
  @override
  List<Object?> get props => [clientId];
}

class DelStoreEvent extends ClientsEvent {
  final int storeId;
  const DelStoreEvent(this.storeId);
  @override
  List<Object?> get props => [storeId];
}
