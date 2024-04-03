part of 'clients_bloc.dart';

class ClientsState extends Equatable {

  final List<Client> clients;
  final RequestState getClientsState;
  final String getClientsErrorMessage;

  const ClientsState({
    this.clients = const [],
    this.getClientsState = RequestState.loading,
    this.getClientsErrorMessage = '',
});

  ClientsState copyWith({
    List<Client>? clients,
    RequestState? getClientsState,
    String? getClientsErrorMessage,
  }) {
    return ClientsState(
      clients: clients ?? this.clients,
      getClientsState: getClientsState ?? this.getClientsState,
      getClientsErrorMessage: getClientsErrorMessage ?? this.getClientsErrorMessage,
    );
  }

  @override
  List<Object> get props => [clients, getClientsState, getClientsErrorMessage];
}
