class ApiConstants {
  static const Duration apiTimeOut = Duration(minutes: 1);
  static String token = '';

  static const String baseUrl = "https://f402-105-40-220-125.ngrok-free.app/api/";

  /// Authentication
  static const String loginPath = "auth/login";
  static const String registerPath = "auth/register";

  /// Home
  static const String getProductsPath = "app/products";
  static const String storeProductPath = "app/products/store";
  static const String updateProductPath = "app/products/update";
  static String delProductPath(int productId) => "app/products/delete/$productId";

  /// Settings
  static const String getSettingsPath = "app/setting";
  static const String updateSettingsPath = "app/setting/update";

  /// Wards
  static const String getWardsPath = "app/parts";

  /// Clients
  static const String getClientsPath = "app/customer/";
  static const String addClientPath = "app/customer/store";
}