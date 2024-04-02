part of 'wards_bloc.dart';

@immutable
abstract class WardsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetWardsEvent extends WardsEvent {}
