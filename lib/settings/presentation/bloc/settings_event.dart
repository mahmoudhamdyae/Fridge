part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
  @override
  List<Object> get props => [];
}

class GetSettingsEvent extends SettingsEvent {}

class UpdateSettingsEvent extends SettingsEvent {
  final List<String> products;
  final List<String> boxing;
  final String units;
  final int price;
  final int wardsNumber;

  const UpdateSettingsEvent(this.products, this.boxing, this.units, this.price, this.wardsNumber);

  @override
  List<Object> get props => [products, boxing, units, price, wardsNumber];
}
