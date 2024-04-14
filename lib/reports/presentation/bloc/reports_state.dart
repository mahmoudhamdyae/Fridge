part of 'reports_bloc.dart';

@immutable
sealed class ReportsState extends Equatable {
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
