import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fridge/reports/domain/entities/analysis.dart';
import 'package:meta/meta.dart';

import '../../domain/usecases/get_analysis_usecase.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {

  final GetAnalysisUsecase _getAnalysisUsecase;

  ReportsBloc(
      this._getAnalysisUsecase
      ) : super(const ReportsState()) {
    on<GetAnalysisEvent>((event, emit) async {
      await _getAnalysis(event, emit);
    });
    on<GetSummaryEvent>((event, emit) async {
      await _geSummary(emit);
    });
    on<GetWeekEvent>((event, emit) async {
      await _geWeek(emit);
    });
    on<GetMonthEvent>((event, emit) async {
      await _geMonth(emit);
    });
  }

  Future<void> _getAnalysis(GetAnalysisEvent event, Emitter<ReportsState> emit) async {
    var result = await _getAnalysisUsecase.call();
    result.fold((l) {
      emit(GetAnalysisErrorState(l.message));
    }, (analysis) {
      emit(GetAnalysisLoadedState(analysis));
    });
  }

  Future<void> _geSummary(Emitter<ReportsState> emit) async {
    var result = await _getAnalysisUsecase.call();
    result.fold((l) {
      emit(GetSummaryErrorState(l.message));
    }, (summary) {
      emit(const GetSummaryLoadedState());
    });
  }

  Future<void> _geWeek(Emitter<ReportsState> emit) async {
    var result = await _getAnalysisUsecase.call();
    result.fold((l) {
      emit(GetWeekErrorState(l.message));
    }, (week) {
      emit(const GetWeekLoadedState());
    });
  }

  Future<void> _geMonth(Emitter<ReportsState> emit) async {
    var result = await _getAnalysisUsecase.call();
    result.fold((l) {
      emit(GetMonthErrorState(l.message));
    }, (week) {
      emit(const GetMonthLoadedState());
    });
  }
}
