part of 'wards_bloc.dart';

@immutable
class WardsState extends Equatable {

  final List<Ward> wards;
  final RequestState getWardsState;
  final String getWardsErrorMessage;

  final RequestState updateWardSettingsState;
  final String updateWardSettingsErrorMessage;

  final List<Store> stores;
  final Map<String, List<CustomCustomer>> customMap;
  final RequestState getAllStoresState;
  final String getAllStoresMessage;

  const WardsState({
    this.wards = const [],
    this.getWardsState = RequestState.loading,
    this.getWardsErrorMessage = '',
    this.updateWardSettingsState = RequestState.init,
    this.updateWardSettingsErrorMessage = '',
    this.stores = const [],
    this.customMap = const {},
    this.getAllStoresState = RequestState.loading,
    this.getAllStoresMessage = ''
  });

  WardsState copyWith({
    List<Ward>? wards,
    RequestState? getWardsState,
    String? getWardsErrorMessage,
    RequestState? updateWardSettingsState,
    String? updateWardSettingsErrorMessage,
    List<Store>? stores,
    Map<String, List<CustomCustomer>>? customMap,
    RequestState? getAllStoresState,
    String? getAllStoresMessage
  }) {
    return WardsState(
      wards: wards ?? this.wards,
      getWardsState: getWardsState ?? this.getWardsState,
      getWardsErrorMessage: getWardsErrorMessage ?? this.getWardsErrorMessage,
      updateWardSettingsState: updateWardSettingsState ?? this.updateWardSettingsState,
      updateWardSettingsErrorMessage: updateWardSettingsErrorMessage ?? this.updateWardSettingsErrorMessage,
      stores: stores ?? this.stores,
      customMap: customMap ?? this.customMap,
      getAllStoresState: getAllStoresState ?? this.getAllStoresState,
      getAllStoresMessage: getAllStoresMessage ?? this.getAllStoresMessage,
    );
}

  @override
  List<Object?> get props => [
    wards, getWardsState, getWardsErrorMessage,
    updateWardSettingsState, updateWardSettingsErrorMessage,
    stores, customMap, getAllStoresState, getAllStoresMessage,
  ];
}
