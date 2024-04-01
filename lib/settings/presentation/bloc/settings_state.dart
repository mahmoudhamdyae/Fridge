part of 'settings_bloc.dart';

class SettingsState extends Equatable {

  final SettingsResponse? settingsResponse;
  final RequestState getSettingsState;
  final String getSettingsErrorMessage;
  final RequestState updateSettingsState;
  final String updateSettingsErrorMessage;

  const SettingsState({
    this.settingsResponse,
    this.getSettingsState = RequestState.loading,
    this.getSettingsErrorMessage = '',
    this.updateSettingsState = RequestState.loaded,
    this.updateSettingsErrorMessage = ''
  });

  SettingsState copyWith({
    SettingsResponse? settingsResponse,
    RequestState? getSettingsState,
    String? getSettingsErrorMessage,
    RequestState? updateSettingsState,
    String? updateSettingsErrorMessage,
}) {
    return SettingsState(
      settingsResponse: settingsResponse ?? this.settingsResponse,
      getSettingsState: getSettingsState ?? this.getSettingsState,
      getSettingsErrorMessage: getSettingsErrorMessage ?? this.getSettingsErrorMessage,
      updateSettingsState: updateSettingsState ?? this.updateSettingsState,
      updateSettingsErrorMessage: updateSettingsErrorMessage ?? this.updateSettingsErrorMessage,
    );
}

  @override
  List<Object> get props => [
    settingsResponse!,
    getSettingsState,
    getSettingsErrorMessage,
    updateSettingsState,
    updateSettingsErrorMessage
  ];
}
