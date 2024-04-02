import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fridge/ward/domain/entities/ward.dart';
import 'package:fridge/ward/domain/usecases/get_wards_usecase.dart';
import 'package:meta/meta.dart';

import '../../../core/enums/request_state.dart';

part 'wards_event.dart';
part 'wards_state.dart';

class WardsBloc extends Bloc<WardsEvent, WardsState> {

  final GetWardsUsecase _getWardsUsecase;

  WardsBloc(
      this._getWardsUsecase
      ) : super(const WardsState()) {
    on<GetWardsEvent>((event, emit) async {
      await _getWardsEvent(event, emit);
    });
  }

  Future<void> _getWardsEvent(GetWardsEvent event, Emitter<WardsState> emit) async {
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
}
