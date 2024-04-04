import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fridge/settings/data/models/settings_request.dart';
import 'package:fridge/settings/domain/entities/settings_response.dart';
import 'package:fridge/settings/domain/usecases/update_settings_usecase.dart';
import 'package:meta/meta.dart';

import '../../../core/enums/request_state.dart';
import '../../domain/usecases/get_settings_usecase.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {

  final GetSettingsUsecase getSettingsUsecase;
  final UpdateSettingsUsecase updateSettingsUsecase;

  SettingsBloc(
      this.getSettingsUsecase,
      this.updateSettingsUsecase,
      ) : super(const SettingsState()) {
    on<GetSettingsEvent>((event, emit) async {
      await _getSettings(event, emit);
    });
    on<UpdateSettingsEvent>((event, emit) async {
      await _updateSettings(event, emit);
    });
    on<UpdateWardNumberEvent>((event, emit) async {
      await _updateWardNumber(event, emit);
    });
    on<UpdateProductTypeEvent>((event, emit) async {
      await _updateProductType(event, emit);
    });
    on<UpdatePackagingTypeEvent>((event, emit) async {
      await _updatePackagingType(event, emit);
    });
    on<UpdateUnitEvent>((event, emit) async {
      await _updateUnit(event, emit);
    });
    on<UpdatePriceEvent>((event, emit) async {
      await _updatePrice(event, emit);
    });
  }

  Future<void> _getSettings(GetSettingsEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(
          partsCount: 234,
        price: '1276'
      ));
    // final result = await getSettingsUsecase.call();
    // result.fold((l) {
    //   emit(state.copyWith(
    //     getSettingsState: RequestState.error,
    //     getSettingsErrorMessage: l.message,
    //   ));
    // }, (settingsResponse) {
    //   emit(state.copyWith(
    //     settingsResponse: settingsResponse,
    //     getSettingsState: RequestState.loaded,
    //   ));
    // });
  }

  Future<void> _updateSettings(UpdateSettingsEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(updateSettingsState: RequestState.loading));
    List<String> products = [];
    for (var element in event.products) {
      products.add(element);
    }
    List<String> boxing = [];
    for (var element in event.boxing) {
      boxing.add(element);
    }
    final result = await updateSettingsUsecase.call(
        SettingsRequest(
          products: products,
          boxing: boxing,
          units: event.units,
          price: event.price,
          partsCount: event.wardsNumber
        )
    );
    result.fold((l) {
      emit(state.copyWith(
        updateSettingsState: RequestState.error,
        updateSettingsErrorMessage: l.message,
      ));
    }, (r) {
      emit(state.copyWith(updateSettingsState: RequestState.loaded));
    });
  }

  Future<void> _updateWardNumber(UpdateWardNumberEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(partsCount: event.wardsNumber));
  }

  Future<void> _updateProductType(UpdateProductTypeEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(products: event.productTypes));
  }

  Future<void> _updatePackagingType(UpdatePackagingTypeEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(boxing: event.packagingTypes));
  }

  Future<void> _updateUnit(UpdateUnitEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(units: event.unit));
  }

  Future<void> _updatePrice(UpdatePriceEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(price: event.price.toString()));
  }
}
