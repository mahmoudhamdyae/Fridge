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
  final String bagType;

  const AddProductEvent(
      this.productType,
      this.packagingType,
      this.number,
      this.unitWeight,
      this.totalWeight,
      this.price,
      this.paid,
      this.bagType,
      );
  @override
  List<Object?> get props => [productType, packagingType, number, unitWeight, totalWeight, price, paid, bagType];
}

class ChooseWardEvent extends ClientsEvent {
  final Ward ward;
  const ChooseWardEvent(this.ward);
  @override
  List<Object?> get props => [ward];
}

class ChoosePlaceEvent extends ClientsEvent {
  final List<Position> positions;
  const ChoosePlaceEvent(this.positions);
  @override
  List<Object?> get props => [positions];
}

class Position extends Equatable {
  final int x;
  final int y;
  const Position(this.x, this.y);
  @override
  List<Object?> get props => [x, y];
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['x_axies'] = x;
    data['y_axies'] = y;
    return data;
  }
}

class FinishEvent extends ClientsEvent {
  final List<Position> positions;
  const FinishEvent(this.positions);
  @override
  List<Object?> get props => [positions];
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

class AddPaidEvent extends ClientsEvent {
  final String paid;
  final int clientId;
  const AddPaidEvent(this.paid, this.clientId);
  @override
  List<Object?> get props => [paid, clientId];
}

class GetAmountPaidEvent extends ClientsEvent {
  final int clientId;
  const GetAmountPaidEvent(this.clientId);
  @override
  List<Object?> get props => [clientId];
}
