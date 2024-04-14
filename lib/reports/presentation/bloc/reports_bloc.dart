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
      ) : super(const GetAnalysisLoadingState()) {
    on<GetAnalysisEvent>((event, emit) async {
      await _getAnalysis(event, emit);
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
}
