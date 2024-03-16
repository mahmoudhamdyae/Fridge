part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final AuthStatus status;
  final AuthError? error;

  AuthState._({
    this.status = AuthStatus.unknown,
    this.error,
  }) {
    print('================ee2345 ${error}');
  }

  AuthState.unKnown(): this._();

  AuthState.firstEntry(): this._(
    status: AuthStatus.firstEntry,
  );

  AuthState.authenticated(): this._(
    status: AuthStatus.authenticated,
  );

  AuthState.unAuthenticated(): this._(
    status: AuthStatus.unAuthenticated,
  );

  AuthState.error({AuthError error = AuthError.unknown})
      : this._(status: AuthStatus.unknown, error: error);

  @override
  List<Object?> get props => [status, error];
}