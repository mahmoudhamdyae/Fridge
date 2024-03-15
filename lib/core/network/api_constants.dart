class ApiConstants {
  static const Duration apiTimeOut = Duration(minutes: 1);
  static String token = '';

  static const String baseUrl = "https://eb88-105-40-87-98.ngrok-free.app/api/";

  // Authentication

  static const String loginPath =
      "auth/login";

  static const String registerPath =
      "auth/register";
}