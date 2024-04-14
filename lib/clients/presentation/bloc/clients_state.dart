part of 'clients_bloc.dart';

class ClientsState extends Equatable {

  final List<Client> clients;
  final RequestState getClientsState;
  final String getClientsErrorMessage;

  final List<dynamic> remoteProductsTypes;
  final List<dynamic> remotePackagingTypes;
  final String remotePrice;

  final List<Ward> wards;
  final Ward ward;

  final String clientName;
  final String clientPhone;
  final String clientAddress;
  final int clientType;

  final ProductToAdd productToAdd;

  final int x;
  final int y;

  final RequestState addClientState;
  final String addClientErrorMessage;

  final List<Store> stores;
  final Map<String, List<CustomCustomer>> customMap;
  final RequestState getStoresState;
  final String getStoresErrorMessage;

  const ClientsState({
    this.clients = const [],
    this.getClientsState = RequestState.loading,
    this.getClientsErrorMessage = '',
    this.remoteProductsTypes = const [],
    this.remotePackagingTypes = const [],
    this.remotePrice = '',
    this.wards = const [],
    this.ward = const Ward(),
    this.clientName = '',
    this.clientPhone = '',
    this.clientAddress = '',
    this.clientType = 0,
    this.productToAdd = const ProductToAdd(),
    this.x = 0,
    this.y = 0,
    this.addClientState = RequestState.loading,
    this.addClientErrorMessage = '',
    this.stores = const [],
    this.customMap = const {},
    this.getStoresState = RequestState.init,
    this.getStoresErrorMessage = ''
});

  ClientsState copyWith({
    List<Client>? clients,
    RequestState? getClientsState,
    String? getClientsErrorMessage,
    List<dynamic>? remoteProductsTypes,
    List<dynamic>? remotePackagingTypes,
    String? remotePrice,
    List<Ward>? wards,
    Ward? ward,
    String? clientName,
    String? clientPhone,
    String? clientAddress,
    int? clientType,
    ProductToAdd? productToAdd,
    int? x,
    int? y,
    RequestState? addClientState,
    String? addClientErrorMessage,
    List<Store>? stores,
    Map<String, List<CustomCustomer>>? customMap,
    RequestState? getStoresState,
    String? getStoresErrorMessage
  }) {
    return ClientsState(
      clients: clients ?? this.clients,
      getClientsState: getClientsState ?? this.getClientsState,
      getClientsErrorMessage: getClientsErrorMessage ?? this.getClientsErrorMessage,
      remoteProductsTypes: remoteProductsTypes ?? this.remoteProductsTypes,
      remotePackagingTypes: remotePackagingTypes ?? this.remotePackagingTypes,
      remotePrice: remotePrice ?? this.remotePrice,
      wards: wards ?? this.wards,
      ward: ward ?? this.ward,
      clientName: clientName ?? this.clientName,
      clientPhone: clientPhone ?? this.clientPhone,
      clientAddress: clientAddress ?? this.clientAddress,
      clientType: clientType ?? this.clientType,
      productToAdd: productToAdd ?? this.productToAdd,
      x: x ?? this.x,
      y: y ?? this.y,
      addClientState: addClientState ?? this.addClientState,
      addClientErrorMessage: addClientErrorMessage ?? this.addClientErrorMessage,
      stores: stores ?? this.stores,
      customMap: customMap ?? this.customMap,
      getStoresState: getStoresState ?? this.getStoresState,
      getStoresErrorMessage: getStoresErrorMessage ?? this.getStoresErrorMessage
    );
  }

  @override
  List<Object> get props => [
    clients, getClientsState, getClientsErrorMessage,
    remoteProductsTypes, remotePackagingTypes, remotePrice,
    wards, ward,
    clientName, clientPhone, clientAddress, clientType,
    productToAdd,
    x, y,
    addClientState, addClientErrorMessage,
    stores, customMap, getStoresState, getStoresErrorMessage
  ];
}
