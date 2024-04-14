part of 'reports_bloc.dart';

@immutable
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
  const GetWeekLoadedState();
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
  const GetMonthLoadedState();
}