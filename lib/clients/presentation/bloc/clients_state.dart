part of 'clients_bloc.dart';

class ClientsState extends Equatable {

  final List<Client> clients;
  final RequestState getClientsState;
  final String getClientsErrorMessage;

  final RequestState addClientState;
  final String clientName;
  final String clientPhone;
  final String clientAddress;
  final int clientType;

  const ClientsState({
    this.clients = const [],
    this.getClientsState = RequestState.loading,
    this.getClientsErrorMessage = '',
    this.addClientState = RequestState.init,
    this.clientName = '',
    this.clientPhone = '',
    this.clientAddress = '',
    this.clientType = 0,
});

  ClientsState copyWith({
    List<Client>? clients,
    RequestState? getClientsState,
    String? getClientsErrorMessage,
    RequestState? addClientState,
    String? clientName,
    String? clientPhone,
    String? clientAddress,
    int? clientType,
  }) {
    return ClientsState(
      clients: clients ?? this.clients,
      getClientsState: getClientsState ?? this.getClientsState,
      getClientsErrorMessage: getClientsErrorMessage ?? this.getClientsErrorMessage,
      addClientState: addClientState ?? this.addClientState,
      clientName: clientName ?? this.clientName,
      clientPhone: clientPhone ?? this.clientPhone,
      clientAddress: clientAddress ?? this.clientAddress,
      clientType: clientType ?? this.clientType,
    );
  }

  @override
  List<Object> get props => [
    clients, getClientsState, getClientsErrorMessage,
    addClientState, clientName, clientPhone, clientAddress, clientType,
  ];
}
