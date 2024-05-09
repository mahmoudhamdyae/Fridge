part of 'reports_bloc.dart';

sealed class ReportsEvent {}

class GetAnalysisEvent extends ReportsEvent {}

class GetSummaryEvent extends ReportsEvent {}
class GetWeekEvent extends ReportsEvent {}
class GetMonthEvent extends ReportsEvent {}
class GetYearEvent extends ReportsEvent {}
