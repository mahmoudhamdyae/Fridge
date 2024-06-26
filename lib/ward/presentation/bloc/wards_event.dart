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

class GetAllStoresEvent extends WardsEvent {
  final Ward ward;
  GetAllStoresEvent(this.ward);
  @override
  List<Object> get props => [ward];
}

class GetInvoiceEvent extends WardsEvent {
  final int storeId;
  GetInvoiceEvent(this.storeId);
  @override
  List<Object> get props => [storeId];
}
