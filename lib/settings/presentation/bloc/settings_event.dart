part of 'settings_bloc.dart';

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
  final double price;
  final int wardsNumber;
  final double smallBags;
  final double largeBags;

  const UpdateSettingsEvent(this.products, this.boxing, this.units, this.price, this.wardsNumber, this.smallBags, this.largeBags);

  @override
  List<Object> get props => [products, boxing, units, price, wardsNumber, smallBags, largeBags];
}

class UpdateWardNumberEvent extends SettingsEvent {
  final int wardsNumber;
  const UpdateWardNumberEvent(this.wardsNumber);
  @override
  List<Object> get props => [wardsNumber];
}

class UpdateProductTypeEvent extends SettingsEvent {
  final List<String> productTypes;
  const UpdateProductTypeEvent(this.productTypes);
  @override
  List<Object> get props => [productTypes];
}

class UpdatePackagingTypeEvent extends SettingsEvent {
  final List<String> packagingTypes;
  const UpdatePackagingTypeEvent(this.packagingTypes);
  @override
  List<Object> get props => [packagingTypes];
}

class UpdateUnitEvent extends SettingsEvent {
  final String unit;
  const UpdateUnitEvent(this.unit);
  @override
  List<Object> get props => [unit];
}

class UpdatePriceEvent extends SettingsEvent {
  final double price;
  const UpdatePriceEvent(this.price);
  @override
  List<Object> get props => [price];
}
