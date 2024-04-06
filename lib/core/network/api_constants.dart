class ApiConstants {
  static const Duration apiTimeOut = Duration(minutes: 1);
  static String token = '';
  static bool isAuth = false;

  static const String baseUrl = "https://ef33-105-32-0-144.ngrok-free.app/api/";

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
  static const String updateWardSettingsPath = "app/parts/update";

  /// Clients
  static const String getClientsPath = "app/customer/";
  static const String addClientPath = "app/customer/store";

  /// Expenses
  static const String getExpensePath = "app/expense";
  static const String storeExpensePath = "app/expense/store";
}