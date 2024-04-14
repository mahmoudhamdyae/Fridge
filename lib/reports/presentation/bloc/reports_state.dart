part of 'reports_bloc.dart';

class ReportsState extends Equatable {
  const ReportsState();
  @override
  List<Object> get props => [];
}

/// Analysis

final class GetAnalysisLoadingState extends ReportsState {
  const GetAnalysisLoadingState();
}

final class GetAnalysisErrorState extends ReportsState {
  final String errorMessage;
  const GetAnalysisErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

final class GetAnalysisLoadedState extends ReportsState {
  final List<Analysis> analysis;
  const GetAnalysisLoadedState(this.analysis);
  @override
  List<Object> get props => [analysis];
}

/// Summary

final class GetSummaryLoadingState extends ReportsState {
  const GetSummaryLoadingState();
}

final class GetSummaryErrorState extends ReportsState {
  final String errorMessage;
  const GetSummaryErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

final class GetSummaryLoadedState extends ReportsState {
  const GetSummaryLoadedState();
}

/// Week

final class GetWeekLoadingState extends ReportsState {
  const GetWeekLoadingState();
}

final class GetWeekErrorState extends ReportsState {
  final String errorMessage;
  const GetWeekErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

final class GetWeekLoadedState extends ReportsState {
  final List<Week> weeks;
  const GetWeekLoadedState(this.weeks);
  @override
  List<Object> get props => [weeks];
}

/// Month

final class GetMonthLoadingState extends ReportsState {
  const GetMonthLoadingState();
}

final class GetMonthErrorState extends ReportsState {
  final String errorMessage;
  const GetMonthErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

final class GetMonthLoadedState extends ReportsState {
  final List<Month> months;
  const GetMonthLoadedState(this.months);
  @override
  List<Object> get props => [months];
}