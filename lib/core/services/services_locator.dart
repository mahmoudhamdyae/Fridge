import 'package:fridge/auth/data/data_source/auth_local_data_source.dart';
import 'package:fridge/auth/data/data_source/auth_remote_data_source.dart';
import 'package:fridge/auth/data/repository/auth_repository_impl.dart';
import 'package:fridge/auth/domain/repository/auth_repository.dart';
import 'package:fridge/auth/domain/usecases/is_first_entry_usecase.dart';
import 'package:fridge/auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:fridge/auth/domain/usecases/login_usecase.dart';
import 'package:fridge/auth/domain/usecases/register_usecase.dart';
import 'package:fridge/auth/domain/usecases/sign_out_usecase.dart';
import 'package:fridge/clients/data/data_source/client_remote_data_source.dart';
import 'package:fridge/clients/domain/repository/client_repository.dart';
import 'package:fridge/clients/domain/usecases/add_client_usecase.dart';
import 'package:fridge/clients/domain/usecases/get_clients_usecase.dart';
import 'package:fridge/clients/presentation/bloc/clients_bloc.dart';
import 'package:fridge/core/network/dio_manager.dart';
import 'package:fridge/expenses/data/data_source/expenses_remote_data_source.dart';
import 'package:fridge/expenses/data/repository/expenses_repository_impl.dart';
import 'package:fridge/expenses/domain/repository/expenses_repository.dart';
import 'package:fridge/expenses/domain/usecases/get_expenses_usecase.dart';
import 'package:fridge/expenses/domain/usecases/store_expenses_usecase.dart';
import 'package:fridge/home/data/datasource/home_remote_data_source.dart';
import 'package:fridge/home/domain/repository/home_repository.dart';
import 'package:fridge/home/domain/usecases/del_product_usecase.dart';
import 'package:fridge/home/domain/usecases/get_products_usecase.dart';
import 'package:fridge/home/domain/usecases/store_product_usecase.dart';
import 'package:fridge/home/domain/usecases/update_product_usecase.dart';
import 'package:fridge/home/presentation/bloc/home_bloc.dart';
import 'package:fridge/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:fridge/reports/data/datasource/reports_remote_data_source.dart';
import 'package:fridge/reports/domain/repository/reports_repository.dart';
import 'package:fridge/reports/domain/usecases/get_analysis_usecase.dart';
import 'package:fridge/reports/domain/usecases/get_month_usecase.dart';
import 'package:fridge/reports/domain/usecases/get_week_usecase.dart';
import 'package:fridge/reports/domain/usecases/get_year_usecase.dart';
import 'package:fridge/settings/data/data_source/settings_remote_data_source.dart';
import 'package:fridge/settings/data/repository/settings_repository_impl.dart';
import 'package:fridge/settings/domain/repository/settings_repository.dart';
import 'package:fridge/settings/domain/usecases/get_settings_usecase.dart';
import 'package:fridge/settings/domain/usecases/update_settings_usecase.dart';
import 'package:fridge/settings/presentation/bloc/settings_bloc.dart';
import 'package:fridge/ward/data/data_source/wards_remote_data_source.dart';
import 'package:fridge/ward/domain/repository/wards_repository.dart';
import 'package:fridge/ward/domain/usecases/get_all_stores_usecase.dart';
import 'package:fridge/ward/domain/usecases/get_wards_usecase.dart';
import 'package:fridge/ward/domain/usecases/update_ward_settings_usecase.dart';
import 'package:fridge/ward/presentation/bloc/wards_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/presentation/bloc/auth_bloc.dart';
import '../../clients/data/repository/client_repository_impl.dart';
import '../../clients/domain/usecases/del_client_usecase.dart';
import '../../clients/domain/usecases/del_store_usecase.dart';
import '../../clients/domain/usecases/add_paid_usecase.dart';
import '../../clients/domain/usecases/get_amount_paid_usecase.dart';
import '../../clients/domain/usecases/get_client_invoice_usecase.dart';
import '../../clients/domain/usecases/sahb_store_usecase.dart';
import '../../expenses/domain/usecases/del_expenses_type_usecase.dart';
import '../../expenses/domain/usecases/del_expenses_usecase.dart';
import '../../expenses/domain/usecases/edit_expenses_usecase.dart';
import '../../expenses/domain/usecases/get_expenses_type_usecase.dart';
import '../../expenses/domain/usecases/store_expenses_type_usecase.dart';
import '../../expenses/presentation/bloc/expenses_bloc.dart';
import '../../home/data/repository/home_repository_impl.dart';
import '../../reports/data/repository/reports_repository_impl.dart';
import '../../reports/presentation/bloc/reports_bloc.dart';
import '../../ward/data/repository/ward_repository_impl.dart';
import '../../ward/domain/usecases/get_invoice_usecase.dart';

final instance = GetIt.instance;

class ServicesLocator {
  Future<void> init() async {

    /// Shared Preferences
    instance.registerSingletonAsync<SharedPreferences>(
            () => SharedPreferences.getInstance()
    );
    await GetIt.instance.isReady<SharedPreferences>();

    /// Auth

    // Bloc
    instance.registerLazySingleton(() => AuthBloc(
        instance<LoginUsecase>(),
        instance<RegisterUsecase>(),
        instance<SignOutUsecase>(),
        instance<IsLoggedInUsecase>(),
        instance<IsFirstEntryUsecase>(),
    ));
    instance.registerLazySingleton(() => OnboardingBloc());
    // Use Cases
    instance.registerLazySingleton(() => LoginUsecase(instance<AuthRepository>()));
    instance.registerLazySingleton(() => RegisterUsecase(instance<AuthRepository>()));
    instance.registerLazySingleton(() => SignOutUsecase(instance<AuthRepository>()));
    instance.registerLazySingleton(() => IsLoggedInUsecase(instance<AuthRepository>()));
    instance.registerLazySingleton(() => IsFirstEntryUsecase(instance<AuthRepository>()));
    // Repository
    instance.registerLazySingleton<AuthRepository>(
            () => AuthRepositoryImpl(instance<AuthLocalDataSource>(), instance<AuthRemoteDataSource>()));
    // DATA SOURCE
    instance.registerLazySingleton<AuthRemoteDataSource>(
            () => AuthRemoteDataSourceImpl(DioManager.instance));
    instance.registerLazySingleton<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(instance<SharedPreferences>())
    );

    /// Home

    // Bloc
    instance.registerLazySingleton(() => HomeBloc(
      instance<GetProductsUsecase>(),
      instance<StoreProductUsecase>(),
      instance<UpdateProductUsecase>(),
      instance<DelProductUsecase>(),
    ));
    // Use Cases
    instance.registerLazySingleton(() => GetProductsUsecase(instance<HomeRepository>()));
    instance.registerLazySingleton(() => StoreProductUsecase(instance<HomeRepository>()));
    instance.registerLazySingleton(() => UpdateProductUsecase(instance<HomeRepository>()));
    instance.registerLazySingleton(() => DelProductUsecase(instance<HomeRepository>()));
    // Repository
    instance.registerLazySingleton<HomeRepository>(
            () => HomeRepositoryImpl(instance<HomeRemoteDataSource>()));
    // DATA SOURCE
    instance.registerLazySingleton<HomeRemoteDataSource>(
            () => HomeRemoteDataSourceImpl(DioManager.instance));


    /// Settings

    // Bloc
    instance.registerLazySingleton(() => SettingsBloc(
      instance<GetSettingsUsecase>(),
      instance<UpdateSettingsUsecase>(),
    ));
    // Use Cases
    instance.registerLazySingleton(() => GetSettingsUsecase(instance<SettingsRepository>()));
    instance.registerLazySingleton(() => UpdateSettingsUsecase(instance<SettingsRepository>()));
    // Repository
    instance.registerLazySingleton<SettingsRepository>(
            () => SettingsRepositoryImpl(instance<SettingsRemoteDataSource>()));
    // DATA SOURCE
    instance.registerLazySingleton<SettingsRemoteDataSource>(
            () => SettingsRemoteDataSourceImpl(DioManager.instance));

    /// Wards

    // Bloc
    instance.registerLazySingleton(() => WardsBloc(
      instance<GetWardsUsecase>(),
      instance<UpdateWardSettingsUsecase>(),
      instance<GetAllStoresUsecase>(),
      instance<GetInvoiceUsecase>(),
    ));
    // Use Cases
    instance.registerLazySingleton(() => GetWardsUsecase(instance<WardsRepository>()));
    instance.registerLazySingleton(() => UpdateWardSettingsUsecase(instance<WardsRepository>()));
    instance.registerLazySingleton(() => GetAllStoresUsecase(instance<WardsRepository>()));
    instance.registerLazySingleton(() => GetInvoiceUsecase(instance<WardsRepository>()));
    // Repository
    instance.registerLazySingleton<WardsRepository>(
            () => WardsRepositoryImpl(instance<WardsRemoteDataSource>()));
    // DATA SOURCE
    instance.registerLazySingleton<WardsRemoteDataSource>(
            () => WardsRemoteDataSourceImpl(DioManager.instance));

    /// Clients

    // Bloc
    instance.registerLazySingleton(() => ClientsBloc(
      instance<GetSettingsUsecase>(),
      instance<GetWardsUsecase>(),
      instance<GetClientsUsecase>(),
      instance<AddClientUsecase>(),
      instance<GetAllStoresUsecase>(),
      instance<GetClientInvoiceUsecase>(),
      instance<DelClientUsecase>(),
      instance<DelStoreUsecase>(),
      instance<AddPaidUsecase>(),
      instance<GetAmountPaidUsecase>(),
      instance<SahbStoreUsecase>(),
    ));
    // Use Cases
    instance.registerLazySingleton(() => GetClientsUsecase(instance<ClientRepository>()));
    instance.registerLazySingleton(() => AddClientUsecase(instance<ClientRepository>()));
    instance.registerLazySingleton(() => GetClientInvoiceUsecase(instance<ClientRepository>()));
    instance.registerLazySingleton(() => DelClientUsecase(instance<ClientRepository>()));
    instance.registerLazySingleton(() => DelStoreUsecase(instance<ClientRepository>()));
    instance.registerLazySingleton(() => AddPaidUsecase(instance<ClientRepository>()));
    instance.registerLazySingleton(() => GetAmountPaidUsecase(instance<ClientRepository>()));
    instance.registerLazySingleton(() => SahbStoreUsecase(instance<ClientRepository>()));
    // Repository
    instance.registerLazySingleton<ClientRepository>(
            () => ClientRepositoryImpl(instance<ClientRemoteDataSource>()));
    // DATA SOURCE
    instance.registerLazySingleton<ClientRemoteDataSource>(
            () => ClientRemoteDataSourceImpl(DioManager.instance));

    /// Expenses

    // Bloc
    instance.registerLazySingleton(() => ExpensesBloc(
      instance<GetExpensesUsecase>(),
      instance<StoreExpensesUsecase>(),
      instance<DelExpenseUsecase>(),
      instance<EditExpensesUsecase>(),
      instance<GetExpensesTypeUsecase>(),
      instance<StoreExpensesTypeUsecase>(),
      instance<DelExpensesTypeUsecase>(),
    ));
    // Use Cases
    instance.registerLazySingleton(() => StoreExpensesUsecase(instance<ExpensesRepository>()));
    instance.registerLazySingleton(() => GetExpensesUsecase(instance<ExpensesRepository>()));
    instance.registerLazySingleton(() => DelExpenseUsecase(instance<ExpensesRepository>()));
    instance.registerLazySingleton(() => EditExpensesUsecase(instance<ExpensesRepository>()));
    instance.registerLazySingleton(() => GetExpensesTypeUsecase(instance<ExpensesRepository>()));
    instance.registerLazySingleton(() => StoreExpensesTypeUsecase(instance<ExpensesRepository>()));
    instance.registerLazySingleton(() => DelExpensesTypeUsecase(instance<ExpensesRepository>()));
    // Repository
    instance.registerLazySingleton<ExpensesRepository>(
            () => ExpensesRepositoryImpl(instance<ExpensesRemoteDataSource>()));
    // DATA SOURCE
    instance.registerLazySingleton<ExpensesRemoteDataSource>(
            () => ExpensesRemoteDataSourceImpl(DioManager.instance));

    /// Reports

    // Bloc
    instance.registerLazySingleton(() => ReportsBloc(
      instance<GetAnalysisUsecase>(),
      instance<GetWeekUsecase>(),
      instance<GetMonthUsecase>(),
      instance<GetYearUsecase>(),
    ));
    // Use Cases
    instance.registerLazySingleton(() => GetAnalysisUsecase(instance<ReportsRepository>()));
    instance.registerLazySingleton(() => GetWeekUsecase(instance<ReportsRepository>()));
    instance.registerLazySingleton(() => GetMonthUsecase(instance<ReportsRepository>()));
    instance.registerLazySingleton(() => GetYearUsecase(instance<ReportsRepository>()));
    // Repository
    instance.registerLazySingleton<ReportsRepository>(
            () => ReportsRepositoryImpl(instance<ReportsRemoteDataSource>()));
    // DATA SOURCE
    instance.registerLazySingleton<ReportsRemoteDataSource>(
            () => ReportsRemoteDataSourceImpl(DioManager.instance));
  }
}