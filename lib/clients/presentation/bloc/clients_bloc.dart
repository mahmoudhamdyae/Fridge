import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fridge/clients/domain/entities/client.dart';
import 'package:fridge/settings/domain/usecases/get_settings_usecase.dart';

import '../../../core/enums/request_state.dart';
import '../../domain/usecases/get_clients_usecase.dart';

part 'clients_event.dart';
part 'clients_state.dart';

class ClientsBloc extends Bloc<ClientsEvent, ClientsState> {

  final GetSettingsUsecase _getSettingsUsecase;
  final GetClientsUsecase _getClientsUsecase;

  ClientsBloc(
      this._getSettingsUsecase,
      this._getClientsUsecase,
      ) : super(const ClientsState()) {
    on<GetClientsEvent>((event, emit) async {
      await _getClients(event, emit);
    });

    on<AddClientEvent>((event, emit) async {
      await _addClient(event, emit);
    });
  }

  Future<void> _getClients(GetClientsEvent event, Emitter<ClientsState> emit) async {
    final result = await _getClientsUsecase.call();
    result.fold((l) {
      emit(state.copyWith(
        getClientsState: RequestState.error,
        getClientsErrorMessage: l.message,
      ));
    }, (clients) {
      emit(state.copyWith(
        clients: clients,
        getClientsState: RequestState.loaded,
      ));
    });
    // Get Settings
    final getSettingsResult = await _getSettingsUsecase.call();
    getSettingsResult.fold((l) {
    }, (settingsResponse) {
      state.copyWith(
          remoteProductsTypes: settingsResponse.data?.products as List<String>? ?? [],
          remotePackagingTypes: settingsResponse.data?.boxing as List<String>? ?? []
      );
    });
  }

  Future<void> _addClient(AddClientEvent event, Emitter<ClientsState> emit) async {
    state.copyWith(
      addClientState: RequestState.loaded,
      clientName: event.clientName,
      clientPhone: event.clientPhone,
      clientAddress: event.clientAddress,
      clientType: event.isTrader ? 0 : 1,
    );
  }
}
