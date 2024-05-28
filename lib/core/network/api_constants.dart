class ApiConstants {
  static const Duration apiTimeOut = Duration(minutes: 1);
  static String token = '';
  static bool isAuth = false;

  // static const String baseUrl = "https://talaga.coding-site.com/api/";
  static const String baseUrl = "https://23b6-105-43-120-129.ngrok-free.app/api/"; // todo

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
  static String getAllStorePath(int wardId) => "app/store/get/$wardId";
  static String getInvoicePath(int storeId) => "app/store/invoice/$storeId";

  /// Clients
  static const String getClientsPath = "app/customer/";
  static const String addClientPath = "app/customer/new_store";
  static String getClientInvoicePath(int clientId) => "app/customer/report/$clientId";
  static String delStorePath(int storeId) => "app/store/delete/$storeId";
  static String delClientPath(int clientId) => "app/customer/delete/$clientId";
  static String addPaidPath = "app/store/add_amount_paid";
  static String getAmountPaidPath = 'app/store/get_amount_paid';
  static String sahbStore(int storeId) => 'app/store/trashed/$storeId';

  /// Expenses
  static const String getExpensePath = "app/expense";
  static const String storeExpensePath = "app/expense/store";
  static String delExpensePath(int expenseId) => "app/expense/delete/$expenseId";
  static const String editExpensePath = "app/expense/update";
  static const String getExpenseTypesPath = "app/expense/type";
  static const String storeExpenseTypesPath = "app/expense/type/store";
  static String delExpenseTypesPath(int typeId) => "app/expense/type/delete/$typeId";

  /// Reports
  static const String getAnalysisPath = "app/analysis/details";
  static const String getWeekPath = "app/analysis/week";
  static const String getMonthPath = "app/analysis/month";
  static const String getYearPath = "app/analysis/year";
}