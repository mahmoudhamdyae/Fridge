part of 'wards_bloc.dart';

@immutable
class WardsState extends Equatable {

  final List<Ward> wards;
  final RequestState getWardsState;
  final String getWardsErrorMessage;

  const WardsState({
    this.wards = const [],
    this.getWardsState = RequestState.loading,
    this.getWardsErrorMessage = ''
  });

  WardsState copyWith({
    List<Ward>? wards,
    RequestState? getWardsState,
    String? getWardsErrorMessage,
  }) {
    return WardsState(
      wards: wards ?? [],
      getWardsState: getWardsState ?? this.getWardsState,
      getWardsErrorMessage: getWardsErrorMessage ?? this.getWardsErrorMessage,
    );
}

  @override
  List<Object?> get props => [ wards, getWardsState, getWardsErrorMessage ];
}
