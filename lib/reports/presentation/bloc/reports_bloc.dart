import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fridge/reports/data/models/year.dart';
import 'package:fridge/reports/domain/entities/analysis.dart';
import 'package:fridge/reports/domain/usecases/get_month_usecase.dart';
import 'package:fridge/reports/domain/usecases/get_week_usecase.dart';

import '../../data/models/month.dart';
import '../../data/models/week.dart';
import '../../domain/usecases/get_analysis_usecase.dart';
import '../../domain/usecases/get_year_usecase.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {

  final GetAnalysisUsecase _getAnalysisUsecase;
  final GetWeekUsecase _getWeekUsecase;
  final GetMonthUsecase _getMonthUsecase;
  final GetYearUsecase _getYearUsecase;

  ReportsBloc(
      this._getAnalysisUsecase,
      this._getWeekUsecase,
      this._getMonthUsecase,
      this._getYearUsecase
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
    on<GetYearEvent>((event, emit) async {
      await _getYear(emit);
    });
  }

  Future<void> _getAnalysis(GetAnalysisEvent event, Emitter<ReportsState> emit) async {
    emit(const GetAnalysisLoadingState());
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
    emit(const GetWeekLoadingState());
    var result = await _getWeekUsecase.call();
    result.fold((l) {
      emit(GetWeekErrorState(l.message));
    }, (week) {
      emit(GetWeekLoadedState(week));
    });
  }

  Future<void> _geMonth(Emitter<ReportsState> emit) async {
    emit(const GetMonthLoadingState());
    var result = await _getMonthUsecase.call();
    result.fold((l) {
      emit(GetMonthErrorState(l.message));
    }, (month) {
      emit(GetMonthLoadedState(month));
    });
  }

  Future<void> _getYear(Emitter<ReportsState> emit) async {
    emit(const GetYearLoadingState());
    var result = await _getYearUsecase.call();
    result.fold((l) {
      emit(GetYearErrorState(l.message));
    }, (years) {
      emit(GetYearLoadedState(years));
    });
  }
}
