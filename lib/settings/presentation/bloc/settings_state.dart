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
/*

class SettingsState extends Equatable {

  final List<dynamic> products;
  final String units;
  final List<dynamic> boxing;
  final String price;
  final int partsCount;
  final RequestState getSettingsState;
  final String getSettingsErrorMessage;
  final RequestState updateSettingsState;
  final String updateSettingsErrorMessage;

  const SettingsState({
    this.products = const[],
    this.units = 'كجم',
    this.boxing = const [],
    this.price = '',
    this.partsCount = 0,
    this.getSettingsState = RequestState.loading,
    this.getSettingsErrorMessage = '',
    this.updateSettingsState = RequestState.init,
    this.updateSettingsErrorMessage = ''
  });

  SettingsState copyWith({
    List<dynamic>? products,
    String? units,
    List<dynamic>? boxing,
    String? price,
    int? partsCount,
    RequestState? getSettingsState,
    String? getSettingsErrorMessage,
    RequestState? updateSettingsState,
    String? updateSettingsErrorMessage,
}) {
    return SettingsState(
      products: products ?? this.products,
      units: units ?? this.units,
      boxing: boxing ?? this.boxing,
      price: price ?? this.price,
      partsCount: partsCount ?? this.partsCount,
      getSettingsState: getSettingsState ?? this.getSettingsState,
      getSettingsErrorMessage: getSettingsErrorMessage ?? this.getSettingsErrorMessage,
      updateSettingsState: updateSettingsState ?? this.updateSettingsState,
      updateSettingsErrorMessage: updateSettingsErrorMessage ?? this.updateSettingsErrorMessage,
    );
}

  @override
  List<Object> get props => [
    products, units, boxing, price, partsCount,
    getSettingsState,
    getSettingsErrorMessage,
    updateSettingsState,
    updateSettingsErrorMessage
  ];
}
*/
