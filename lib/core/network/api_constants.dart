class ApiConstants {
  static const Duration apiTimeOut = Duration(minutes: 1);
  static String token = '';

  static const String baseUrl = "https://9e7f-105-40-87-98.ngrok-free.app/api/";

  /// Authentication
  static const String loginPath = "auth/login";
  static const String registerPath = "auth/register";

  /// Home
  static const String getProductsPath = "app/products";
  static const String storeProductPath = "app/products/store";
  static const String updateProductPath = "app/products/update";
  static String delProductPath(int productId) => "app/products/delete/$productId";
}