import 'package:fridge/core/resources/app_strings.dart';

enum AuthStatus { firstEntry, unknown, authenticated, unAuthenticated }

enum AuthError {
  unknown(AppStrings.unknownError),
  wrongData(AppStrings.wrongData);

  const AuthError(this.errorMessage);

  final String errorMessage;
}