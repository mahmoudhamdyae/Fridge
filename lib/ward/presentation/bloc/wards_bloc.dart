import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fridge/ward/domain/entities/ward.dart';
import 'package:fridge/ward/domain/usecases/get_wards_usecase.dart';
import 'package:meta/meta.dart';

import '../../../core/enums/request_state.dart';
import '../../domain/usecases/update_ward_settings_usecase.dart';

part 'wards_event.dart';
part 'wards_state.dart';

class WardsBloc extends Bloc<WardsEvent, WardsState> {

  final GetWardsUsecase _getWardsUsecase;
  final UpdateWardSettingsUsecase _updateWardSettingsUsecase;

  WardsBloc(
      this._getWardsUsecase,
      this._updateWardSettingsUsecase,
      ) : super(const WardsState()) {
    on<GetWardsEvent>((event, emit) async {
      await _getWards(emit);
    });
    on<UpdateWardSettingsEvent>((event, emit) async {
      await _updateWardSettingsEvent(event, emit);
    });
  }

  Future<void> _getWards(Emitter<WardsState> emit) async {
    emit(state.copyWith(updateWardSettingsState: RequestState.init));
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

  Future<void> _updateWardSettingsEvent(UpdateWardSettingsEvent event, Emitter<WardsState> emit) async {
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
}
