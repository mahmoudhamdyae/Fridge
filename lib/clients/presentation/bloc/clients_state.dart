part of 'clients_bloc.dart';

class ClientsState extends Equatable {

  final List<Client> clients;
  final RequestState getClientsState;
  final String getClientsErrorMessage;

  final List<String> remoteProductsTypes;
  final List<String> remotePackagingTypes;

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

  const ClientsState({
    this.clients = const [],
    this.getClientsState = RequestState.loading,
    this.getClientsErrorMessage = '',
    this.remoteProductsTypes = const [],
    this.remotePackagingTypes = const [],
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
});

  ClientsState copyWith({
    List<Client>? clients,
    RequestState? getClientsState,
    String? getClientsErrorMessage,
    List<String>? remoteProductsTypes,
    List<String>? remotePackagingTypes,
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
  }) {
    return ClientsState(
      clients: clients ?? this.clients,
      getClientsState: getClientsState ?? this.getClientsState,
      getClientsErrorMessage: getClientsErrorMessage ?? this.getClientsErrorMessage,
      remoteProductsTypes: remoteProductsTypes ?? this.remoteProductsTypes,
      remotePackagingTypes: remotePackagingTypes ?? this.remotePackagingTypes,
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
    );
  }

  @override
  List<Object> get props => [
    clients, getClientsState, getClientsErrorMessage,
    remoteProductsTypes, remotePackagingTypes,
    wards, ward,
    clientName, clientPhone, clientAddress, clientType,
    productToAdd,
    x, y,
    addClientState, addClientErrorMessage,
  ];
}
