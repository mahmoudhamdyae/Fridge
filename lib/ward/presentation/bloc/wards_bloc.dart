import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/ward/data/models/invoice.dart';
import 'package:fridge/ward/data/models/store.dart';
import 'package:fridge/ward/domain/entities/ward.dart';
import 'package:fridge/ward/domain/usecases/get_wards_usecase.dart';
import 'package:meta/meta.dart';

import '../../../core/enums/request_state.dart';
import '../../domain/entities/custom_customer.dart';
import '../../domain/usecases/get_all_stores_usecase.dart';
import '../../domain/usecases/get_invoice_usecase.dart';
import '../../domain/usecases/update_ward_settings_usecase.dart';

part 'wards_event.dart';
part 'wards_state.dart';

class WardsBloc extends Bloc<WardsEvent, WardsState> {

  final GetWardsUsecase _getWardsUsecase;
  final UpdateWardSettingsUsecase _updateWardSettingsUsecase;
  final GetAllStoresUsecase _getAllStoresUsecase;
  final GetInvoiceUsecase _getInvoiceUsecase;

  WardsBloc(
      this._getWardsUsecase,
      this._updateWardSettingsUsecase,
      this._getAllStoresUsecase,
      this._getInvoiceUsecase,
      ) : super(const WardsState()) {
    on<GetWardsEvent>((event, emit) async {
      await _getWards(emit);
    });
    on<UpdateWardSettingsEvent>((event, emit) async {
      await _updateWardSettings(event, emit);
    });
    on<GetAllStoresEvent>((event, emit) async {
      await _getAllStores(event, emit);
    });
    on<GetInvoiceEvent>((event, emit) async {
      await _getInvoice(event, emit);
    });
  }

  Future<void> _getWards(Emitter<WardsState> emit) async {
    final result = await _getWardsUsecase.call();
    result.fold((l) {
      emit(state.copyWith(
        getWardsState: RequestState.error,
        getWardsErrorMessage: l.message,
      ));
    }, (wards) {
      emit(state.copyWith(
        wards: wards,
        getWardsErrorMessage: '',
        getWardsState: RequestState.loaded,
      ));
    });
  }

  Future<void> _updateWardSettings(UpdateWardSettingsEvent event, Emitter<WardsState> emit) async {
    emit(state.copyWith(updateWardSettingsState: RequestState.loading));
    var result = await _updateWardSettingsUsecase.call(event.wardId, event.wardWidth, event.wardHeight);
    result.fold((l) {
      emit(state.copyWith(
        updateWardSettingsState: RequestState.error,
        updateWardSettingsErrorMessage: l.message,
      ));
    }, (r) async {

      add(GetWardsEvent());

      emit(state.copyWith(
        updateWardSettingsState: RequestState.loaded,
      ));
    });
  }

  Future<void> _getAllStores(GetAllStoresEvent event, Emitter<WardsState> emit) async {
    emit(state.copyWith(getAllStoresState: RequestState.loading));
    var result = await _getAllStoresUsecase.call(event.ward.id ?? -1);
    result.fold((l) {
      emit(state.copyWith(
        getAllStoresState: RequestState.error,
        getAllStoresMessage: l.message,
      ));
    }, (stores) async {

      // todo refactor this
      Map<String, List<CustomCustomer>> myCustomMap = state.customMap;
      var c = myCustomMap['${event.ward.width}-${event.ward.height}'];
      c = [];
      for (var element in stores) {
        c.add(CustomCustomer(
            name: element.customer?.name,
            type: element.customer?.type == 0 ? AppStrings.addClientScreenTraderWithQ : AppStrings.addClientScreenDealerWithQ,
            product: element.product,
            quantity: '${element.totalWeight} ${element.unit}',
            storeId: element.id ?? -1,
        ));
      }

      emit(state.copyWith(
        getAllStoresState: RequestState.loaded,
        stores: stores,
        customMap: {
          '${event.ward.width}-${event.ward.height}': c
        },
      ));
    });
  }

  Future<void> _getInvoice(GetInvoiceEvent event, Emitter<WardsState> emit) async {
    emit(state.copyWith(getInvoiceState: RequestState.loading));
    var result = await _getInvoiceUsecase.call(event.storeId);
    result.fold((l) {
      emit(state.copyWith(
        getInvoiceState: RequestState.error,
        getInvoiceErrorMessage: l.message,
      ));
    }, (invoice) async {
      emit(state.copyWith(
        getInvoiceState: RequestState.loaded,
        invoice: invoice,
      ));
    });
  }
}
