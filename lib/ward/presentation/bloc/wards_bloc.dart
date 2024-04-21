import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/ward/domain/entities/ward.dart';
import 'package:fridge/ward/domain/usecases/get_wards_usecase.dart';

import '../../domain/entities/custom_customer.dart';
import '../../domain/entities/invoice.dart';
import '../../domain/entities/store.dart';
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
      ) : super(const GetWardsLoadingState()) {
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
    emit(const GetWardsLoadingState());
    final result = await _getWardsUsecase.call();
    result.fold((l) {
      emit(GetWardsErrorState(l.message));
    }, (wards) {
      emit(GetWardsLoadedState(wards));
    });
  }

  Future<void> _updateWardSettings(UpdateWardSettingsEvent event, Emitter<WardsState> emit) async {
    emit(UpdateWardSettingsLoadingState());
    var result = await _updateWardSettingsUsecase.call(event.wardId, event.wardWidth, event.wardHeight);
    result.fold((l) {
      emit(UpdateWardSettingsErrorState(l.message));
    }, (r) async {

      // todo not here
      add(GetWardsEvent());

      emit(UpdateWardSettingsSuccessState());
    });
  }

  Future<void> _getAllStores(GetAllStoresEvent event, Emitter<WardsState> emit) async {
    emit(GetStoreLoadingState());
    var result = await _getAllStoresUsecase.call(event.ward.id ?? -1);
    result.fold((l) {
      emit(GetStoreErrorState(l.message));
    }, (stores) async {

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

      emit(GetStoreLoadedState(stores));
    });
  }

  Future<void> _getInvoice(GetInvoiceEvent event, Emitter<WardsState> emit) async {
    emit(GetInvoiceLoadingState());
    var result = await _getInvoiceUsecase.call(event.storeId);
    result.fold((l) {
      emit(GetInvoiceErrorState(l.message));
    }, (invoice) async {
      emit(GetInvoiceLoadedState(invoice));
    });
  }
}
