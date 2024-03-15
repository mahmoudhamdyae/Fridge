enum AuthStatus { firstEntry, unknown, authenticated, unAuthenticated }

enum AuthError {
  unknown(''),
  wrongData('');

  const AuthError(String errorMessage);
}