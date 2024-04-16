import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fridge/clients/data/models/client_invoice.dart';
import 'package:fridge/clients/data/models/client_model.dart';
import 'package:fridge/clients/domain/entities/client.dart';
import 'package:fridge/clients/domain/entities/product_to_add.dart';
import 'package:fridge/settings/domain/usecases/get_settings_usecase.dart';
import 'package:fridge/ward/domain/usecases/get_wards_usecase.dart';

import '../../../core/enums/request_state.dart';
import '../../../core/resources/app_strings.dart';
import '../../../ward/domain/entities/custom_customer.dart';
import '../../../ward/domain/entities/store.dart';
import '../../../ward/domain/entities/ward.dart';
import '../../../ward/domain/usecases/get_all_stores_usecase.dart';
import '../../data/models/add_client_request.dart';
import '../../domain/usecases/add_client_usecase.dart';
import '../../domain/usecases/get_client_invoice_usecase.dart';
import '../../domain/usecases/get_clients_usecase.dart';

part 'clients_event.dart';
part 'clients_state.dart';

class ClientsBloc extends Bloc<ClientsEvent, ClientsState> {

  final GetSettingsUsecase _getSettingsUsecase;
  final GetWardsUsecase _getWardsUsecase;
  final GetClientsUsecase _getClientsUsecase;
  final AddClientUsecase _addClientUsecase;
  final GetAllStoresUsecase _getAllStoresUsecase;
  final GetClientInvoiceUsecase _getClientInvoiceUsecase;

  ClientsBloc(
      this._getSettingsUsecase,
      this._getWardsUsecase,
      this._getClientsUsecase,
      this._addClientUsecase,
      this._getAllStoresUsecase,
      this._getClientInvoiceUsecase,
      ) : super(const ClientsState()) {
    on<GetClientsEvent>((event, emit) async {
      await _getClients(event, emit);
    });

    on<SearchClientsEvent>((event, emit) async {
      await _searchClients(event, emit);
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

    on<GetClientInvoiceEvent>((event, emit) async {
      await _getClientInvoice(event, emit);
    });
  }

  Future<void> _getClients(GetClientsEvent event, Emitter<ClientsState> emit) async {
    emit(state.copyWith(addClientState: RequestState.init));
    final result = await _getClientsUsecase.call();
    result.fold((l) {
      emit(state.copyWith(
        getClientsState: RequestState.error,
        getClientsErrorMessage: l.message,
      ));
    }, (clients) {
      emit(state.copyWith(
        clients: clients,
        searchedClients: clients,
        getClientsState: RequestState.loaded,
      ));
    });
    // Get Settings
    final getSettingsResult = await _getSettingsUsecase.call();
    getSettingsResult.fold((l) {
    }, (settingsResponse) {
      emit(state.copyWith(
        remoteProductsTypes: settingsResponse.data?.products ?? [],
        remotePackagingTypes: settingsResponse.data?.boxing ?? [],
        remotePrice: settingsResponse.data?.price,
      ));
    });
    // Get Wards
    final getWardsResult = await _getWardsUsecase.call();
    getWardsResult.fold((l) {
    }, (wards) {
      emit(state.copyWith(
          wards: wards
      ));
    });
  }

  Future<void> _addClient(AddClientEvent event, Emitter<ClientsState> emit) async {
    emit(state.copyWith(
      clientName: event.clientName,
      clientPhone: event.clientPhone,
      clientAddress: event.clientAddress,
      clientType: event.isTrader ? 0 : 1,
    ));
  }

  Future<void> _addProduct(AddProductEvent event, Emitter<ClientsState> emit) async {
    emit(state.copyWith(
      productToAdd: ProductToAdd(
        productType: event.productType,
        packagingType: event.packagingType,
        number: int.parse(event.number),
        unitWeight: int.parse(event.unitWeight),
        totalWeight: int.parse(event.totalWeight),
        price: event.price,
      )
    ));
  }

  Future<void> _chooseWard(ChooseWardEvent event, Emitter<ClientsState> emit) async {
    emit(state.copyWith(
      getStoresState: RequestState.loading,
    ));
    // Get Stores
    final getStoresResult = await _getAllStoresUsecase.call(event.ward.id ?? -1);
    getStoresResult.fold((l) {
      emit(state.copyWith(
        getStoresState: RequestState.error,
        getStoresErrorMessage: l.message,
      ));
    }, (stores) {
      // todo refactor this
      List<CustomCustomer> customCustomers = [];
      for (var element in stores) {
        customCustomers.add(CustomCustomer(
          name: element.customer?.name,
          type: element.customer?.type == 0 ? AppStrings.addClientScreenTraderWithQ : AppStrings.addClientScreenDealerWithQ,
          product: element.product,
          quantity: '${element.totalWeight} ${element.unit}',
          storeId: element.id ?? -1,
        ));
      }

      emit(state.copyWith(
        getStoresState: RequestState.loaded,
        stores: stores,
        ward: event.ward,
        customMap: { '${event.ward.width}-${event.ward.height}': customCustomers }
      ));
    });
  }

  Future<void> _choosePlace(ChoosePlaceEvent event, Emitter<ClientsState> emit) async {
    emit(state.copyWith(
      x: event.x,
      y: event.y,
    ));
  }

  Future<void> _finish(FinishEvent event, Emitter<ClientsState> emit) async {
    emit(state.copyWith(addClientState: RequestState.loading));
    final result = await _addClientUsecase.call(
      AddClientRequest(
          name: state.clientName,
          phone: state.clientPhone,
          address: state.clientAddress,
          type: state.clientType,
          productType: state.productToAdd.productType,
          packagingType: state.productToAdd.packagingType,
          wardId: state.ward.id,
          number: state.productToAdd.number,
          unitWeight: state.productToAdd.unitWeight,
          totalWeight: state.productToAdd.totalWeight,
          price: state.productToAdd.price,
          x: event.x,
          y: event.y,
      )
    );
    result.fold((l) {
      emit(state.copyWith(
        addClientState: RequestState.error,
        addClientErrorMessage: l.message,
      ));
    }, (r) {
      var clients = state.clients;
      clients.add(ClientModel(
          id: -1,
          name: state.clientName,
          phone: state.clientPhone,
          address: state.clientAddress,
          type: state.clientType,
          fridgeId: state.ward.id
      ));
      emit(state.copyWith(
        addClientState: RequestState.loaded,
        clients: clients,
        searchedClients: clients,
        clientName: '',
        clientPhone: '',
        clientAddress: '',
        clientType: 0,
        productToAdd: const ProductToAdd(),
        x: 0,
        y: 0,
      ));
    });
  }

  Future<void> _searchClients(SearchClientsEvent event, Emitter<ClientsState> emit) async {
    String search = event.search;
    var clients = state.clients.where((element) =>
        element.name!.contains(search) || element.phone!.contains(search)
    );
    emit(
      state.copyWith(
        searchedClients: clients.toList()
      )
    );
  }

  Future<void> _getClientInvoice(GetClientInvoiceEvent event, Emitter<ClientsState> emit) async {
    emit(state.copyWith(getInvoiceState: RequestState.loading));
    final result = await _getClientInvoiceUsecase.call(event.clientId);
    result.fold((l) {
      emit(state.copyWith(getInvoiceState: RequestState.error));
    }, (invoice) {
      emit(state.copyWith(
        getInvoiceState: RequestState.loaded,
        invoice: invoice,
      ));
    });
  }
}
