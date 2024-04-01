part of 'clients_bloc.dart';

sealed class ClientsState extends Equatable {
  const ClientsState();
}

final class ClientsInitial extends ClientsState {
  @override
  List<Object> get props => [];
}
