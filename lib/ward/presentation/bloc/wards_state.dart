part of 'wards_bloc.dart';

@immutable
class WardsState extends Equatable {
  const WardsState();
  @override
  List<Object> get props => [];
}

/// Get Wards

class GetWardsLoadingState extends WardsState {
  const GetWardsLoadingState();
}

class GetWardsErrorState extends WardsState {
  final String errorMessage;
  const GetWardsErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class GetWardsLoadedState extends WardsState {
  final List<Ward> wards;
  const GetWardsLoadedState(this.wards);
  @override
  List<Object> get props => [wards];
}

/// Update Ward Settings

class UpdateWardSettingsLoadingState extends WardsState {}

class UpdateWardSettingsErrorState extends WardsState {
  final String errorMessage;
  const UpdateWardSettingsErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class UpdateWardSettingsSuccessState extends WardsState {}

/// Get Stores

class GetStoreLoadingState extends WardsState {}

class GetStoreErrorState extends WardsState {
  final String errorMessage;
  const GetStoreErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class GetStoreLoadedState extends WardsState {
  final List<Store> stores;
  final Map<String, List<CustomCustomer>> customMap;
  const GetStoreLoadedState(this.stores, this.customMap);
  @override
  List<Object> get props => [stores, customMap];
}

/// Get Invoice

class GetInvoiceLoadingState extends WardsState {}

class GetInvoiceErrorState extends WardsState {
  final String errorMessage;
  const GetInvoiceErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class GetInvoiceLoadedState extends WardsState {
  final Invoice invoice;
  const GetInvoiceLoadedState(this.invoice);
  @override
  List<Object> get props => [invoice];
}