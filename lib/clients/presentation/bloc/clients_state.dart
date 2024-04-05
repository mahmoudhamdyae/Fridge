part of 'clients_bloc.dart';

class ClientsState extends Equatable {

  final List<Client> clients;
  final RequestState getClientsState;
  final String getClientsErrorMessage;

  final List<String> remoteProductsTypes;
  final List<String> remotePackagingTypes;

  final String clientName;
  final String clientPhone;
  final String clientAddress;
  final int clientType;

  final ProductToAdd productToAdd;

  const ClientsState({
    this.clients = const [],
    this.getClientsState = RequestState.loading,
    this.getClientsErrorMessage = '',
    this.remoteProductsTypes = const [],
    this.remotePackagingTypes = const [],
    this.clientName = '',
    this.clientPhone = '',
    this.clientAddress = '',
    this.clientType = 0,
    this.productToAdd = const ProductToAdd(),
});

  ClientsState copyWith({
    List<Client>? clients,
    RequestState? getClientsState,
    String? getClientsErrorMessage,
    List<String>? remoteProductsTypes,
    List<String>? remotePackagingTypes,
    RequestState? addClientState,
    String? clientName,
    String? clientPhone,
    String? clientAddress,
    int? clientType,
    ProductToAdd? productToAdd
  }) {
    return ClientsState(
      clients: clients ?? this.clients,
      getClientsState: getClientsState ?? this.getClientsState,
      getClientsErrorMessage: getClientsErrorMessage ?? this.getClientsErrorMessage,
      remoteProductsTypes: remoteProductsTypes ?? this.remoteProductsTypes,
      remotePackagingTypes: remotePackagingTypes ?? this.remotePackagingTypes,
      clientName: clientName ?? this.clientName,
      clientPhone: clientPhone ?? this.clientPhone,
      clientAddress: clientAddress ?? this.clientAddress,
      clientType: clientType ?? this.clientType,
      productToAdd: productToAdd ?? this.productToAdd,
    );
  }

  @override
  List<Object> get props => [
    clients, getClientsState, getClientsErrorMessage,
    remoteProductsTypes, remotePackagingTypes,
    clientName, clientPhone, clientAddress, clientType,
    productToAdd,
  ];
}
