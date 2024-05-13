import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fridge/core/resources/app_strings.dart';
import 'package:fridge/settings/data/models/settings_request.dart';
import 'package:fridge/settings/domain/usecases/update_settings_usecase.dart';

import '../../domain/usecases/get_settings_usecase.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {

  final GetSettingsUsecase getSettingsUsecase;
  final UpdateSettingsUsecase updateSettingsUsecase;

  SettingsBloc(
      this.getSettingsUsecase,
      this.updateSettingsUsecase,
      ) : super(const GetSettingsLoadingState()) {
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
    final result = await getSettingsUsecase.call();
    result.fold((l) {
      emit(GetSettingsErrorState(l.message));
    }, (settingsResponse) {
      emit(GetSettingsLoadedState(
          products: settingsResponse.data?.products ?? [],
          units: settingsResponse.data?.units ?? AppStrings.settingsScreenUnitKiloGram,
          boxing: settingsResponse.data?.boxing ?? [],
          price: settingsResponse.data?.price ?? '',
          partsCount: settingsResponse.data?.partsCount ?? 0,
          smallBags: settingsResponse.data?.smallBags ?? 0.0,
          largeBags: settingsResponse.data?.largeBags ?? 0.0,
        )
      );
    });
  }

  Future<void> _updateSettings(UpdateSettingsEvent event, Emitter<SettingsState> emit) async {
    emit(UpdateSettingsLoadingState());
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
          partsCount: event.wardsNumber,
          smallBags: event.smallBags,
          largeBags: event.largeBags,
        )
    );
    result.fold((l) {
      emit(UpdateSettingsErrorState(l.message));
    }, (r) {
      emit(const UpdateSettingsSuccessState());
    });
  }

  Future<void> _updateWardNumber(UpdateWardNumberEvent event, Emitter<SettingsState> emit) async {
    emit(SettingsState(partsCount: event.wardsNumber));
  }

  Future<void> _updateProductType(UpdateProductTypeEvent event, Emitter<SettingsState> emit) async {
    emit(SettingsState(products: event.productTypes));
  }

  Future<void> _updatePackagingType(UpdatePackagingTypeEvent event, Emitter<SettingsState> emit) async {
    emit(SettingsState(boxing: event.packagingTypes));
  }

  Future<void> _updateUnit(UpdateUnitEvent event, Emitter<SettingsState> emit) async {
    emit(SettingsState(units: event.unit));
  }

  Future<void> _updatePrice(UpdatePriceEvent event, Emitter<SettingsState> emit) async {
    emit(SettingsState(price: event.price.toString()));
  }
}
