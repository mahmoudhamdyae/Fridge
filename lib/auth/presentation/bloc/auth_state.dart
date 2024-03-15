part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final AuthStatus status;
  final AuthError? error;

  const AuthState._({
    this.status = AuthStatus.unknown,
    this.error,
  });

  const AuthState.unknown(): this._();

  const AuthState.firstEntry(): this._(
    status: AuthStatus.firstEntry,
  );

  const AuthState.authenticated(): this._(
    status: AuthStatus.authenticated,
  );

  const AuthState.unAuthenticated(): this._(
    status: AuthStatus.unAuthenticated,
  );

  const AuthState.error({AuthError error = AuthError.unknown})
      : this._(status: AuthStatus.unknown, error: error);

  @override
  List<Object?> get props => [status, error];
}