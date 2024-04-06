part of 'wards_bloc.dart';

@immutable
class WardsState extends Equatable {

  final List<Ward> wards;
  final RequestState getWardsState;
  final String getWardsErrorMessage;

  final RequestState updateWardSettingsState;
  final String updateWardSettingsErrorMessage;

  const WardsState({
    this.wards = const [],
    this.getWardsState = RequestState.loading,
    this.getWardsErrorMessage = '',
    this.updateWardSettingsState = RequestState.init,
    this.updateWardSettingsErrorMessage = ''
  });

  WardsState copyWith({
    List<Ward>? wards,
    RequestState? getWardsState,
    String? getWardsErrorMessage,
    RequestState? updateWardSettingsState,
    String? updateWardSettingsErrorMessage
  }) {
    return WardsState(
      wards: wards ?? [],
      getWardsState: getWardsState ?? this.getWardsState,
      getWardsErrorMessage: getWardsErrorMessage ?? this.getWardsErrorMessage,
      updateWardSettingsState: updateWardSettingsState ?? this.updateWardSettingsState,
      updateWardSettingsErrorMessage: updateWardSettingsErrorMessage ?? this.updateWardSettingsErrorMessage
    );
}

  @override
  List<Object?> get props => [
    wards, getWardsState, getWardsErrorMessage,
    updateWardSettingsState, updateWardSettingsErrorMessage
  ];
}
