part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final List<dynamic>? products;
  final String? units;
  final List<dynamic>? boxing;
  final String? price;
  final int? partsCount;
  const SettingsState({
    this.products,
    this.units,
    this.boxing,
    this.price,
    this.partsCount
  });
  @override
  List<Object?> get props => [
    products,
    units,
    boxing,
    price,
    partsCount,
  ];
}

class GetSettingsLoadingState extends SettingsState {
  const GetSettingsLoadingState();
}

class GetSettingsErrorState extends SettingsState {
  final String errorMessage;
  const GetSettingsErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class GetSettingsLoadedState extends SettingsState {
  const GetSettingsLoadedState({
    super.products,
    super.units,
    super.boxing,
    super.price,
    super.partsCount
  });
}

class UpdateSettingsLoadingState extends SettingsState {}

class UpdateSettingsErrorState extends SettingsState {
  final String errorMessage;
  const UpdateSettingsErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class UpdateSettingsSuccessState extends SettingsState {
  const UpdateSettingsSuccessState();
}
