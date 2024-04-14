import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fridge/reports/domain/entities/analysis.dart';
import 'package:fridge/reports/domain/usecases/get_month_usecase.dart';
import 'package:fridge/reports/domain/usecases/get_week_usecase.dart';

import '../../domain/entities/month.dart';
import '../../domain/entities/week.dart';
import '../../domain/usecases/get_analysis_usecase.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {

  final GetAnalysisUsecase _getAnalysisUsecase;
  final GetWeekUsecase _getWeekUsecase;
  final GetMonthUsecase _getMonthUsecase;

  ReportsBloc(
      this._getAnalysisUsecase,
      this._getWeekUsecase,
      this._getMonthUsecase
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
    var result = await _getWeekUsecase.call();
    result.fold((l) {
      emit(GetWeekErrorState(l.message));
    }, (week) {
      emit(GetWeekLoadedState(week));
    });
  }

  Future<void> _geMonth(Emitter<ReportsState> emit) async {
    var result = await _getMonthUsecase.call();
    result.fold((l) {
      emit(GetMonthErrorState(l.message));
    }, (month) {
      emit(GetMonthLoadedState(month));
    });
  }
}
