import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fridge/clients/domain/entities/client.dart';
import 'package:fridge/clients/domain/entities/product_to_add.dart';
import 'package:fridge/settings/domain/usecases/get_settings_usecase.dart';
import 'package:fridge/ward/domain/usecases/get_wards_usecase.dart';

import '../../../core/enums/request_state.dart';
import '../../../ward/domain/entities/ward.dart';
import '../../domain/usecases/get_clients_usecase.dart';

part 'clients_event.dart';
part 'clients_state.dart';

class ClientsBloc extends Bloc<ClientsEvent, ClientsState> {

  final GetSettingsUsecase _getSettingsUsecase;
  final GetWardsUsecase _getWardsUsecase;
  final GetClientsUsecase _getClientsUsecase;

  ClientsBloc(
      this._getSettingsUsecase,
      this._getWardsUsecase,
      this._getClientsUsecase,
      ) : super(const ClientsState()) {
    on<GetClientsEvent>((event, emit) async {
      await _getClients(event, emit);
    });

    on<AddClientEvent>((event, emit) async {
      await _addClient(event, emit);
    });

    on<AddProductEvent>((event, emit) async {
      await _addProduct(event, emit);
    });

    on<ChooseWardEvent>((event, emit) async {
      await _chooseWard(event, emit);
    });

    on<ChoosePlaceEvent>((event, emit) async {
      await _choosePlace(event, emit);
    });

    on<FinishEvent>((event, emit) async {
      await _finish(event, emit);
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
    // Get Wards
    final getWardsResult = await _getWardsUsecase.call();
    getWardsResult.fold((l) {
    }, (wards) {
      state.copyWith(
          wards: wards
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

  Future<void> _addProduct(AddProductEvent event, Emitter<ClientsState> emit) async {
    state.copyWith(
      productToAdd: ProductToAdd(
        productType: event.productType,
        packagingType: event.packagingType,
        number: event.number,
        unitWeight: event.unitWeight,
        totalWeight: event.totalWeight,
        price: event.price,
      )
    );
  }

  Future<void> _chooseWard(ChooseWardEvent event, Emitter<ClientsState> emit) async {
    state.copyWith(
      ward: event.ward,
    );
  }

  Future<void> _choosePlace(ChoosePlaceEvent event, Emitter<ClientsState> emit) async {
    state.copyWith(
      x: event.x,
      y: event.y,
    );
  }

  Future<void> _finish(FinishEvent event, Emitter<ClientsState> emit) async {
  }
}
