part of 'wards_bloc.dart';

@immutable
abstract class WardsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetWardsEvent extends WardsEvent {}

class UpdateWardSettingsEvent extends WardsEvent {
  final int wardId;
  final int wardWidth;
  final int wardHeight;
  UpdateWardSettingsEvent(this.wardId, this.wardWidth, this.wardHeight);
  @override
  List<Object> get props => [wardId, wardWidth, wardHeight];
}
