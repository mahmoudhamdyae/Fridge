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
      await _getSettingsEvent(event, emit);
    });
    on<UpdateSettingsEvent>((event, emit) async {
      await _updateSettingsEvent(event, emit);
    });
  }

  Future<void> _getSettingsEvent(GetSettingsEvent event, Emitter<SettingsState> emit) async {
    final result = await getSettingsUsecase.call();
    result.fold((l) {
      emit(state.copyWith(
        getSettingsState: RequestState.error,
        getSettingsErrorMessage: l.message,
      ));
    }, (settingsResponse) {
      emit(state.copyWith(
        settingsResponse: settingsResponse,
        getSettingsState: RequestState.loaded,
      ));
    });
  }

  Future<void> _updateSettingsEvent(UpdateSettingsEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(updateSettingsState: RequestState.loading));
    final result = await updateSettingsUsecase.call(
        SettingsRequest(
          products: state.settingsResponse?.data?.products,
          boxing: state.settingsResponse?.data?.boxing,
          units: state.settingsResponse?.data?.units,
          price: int.parse(state.settingsResponse?.data?.price ?? '0'),
          partsCount: state.settingsResponse?.data?.partsCount
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
}
