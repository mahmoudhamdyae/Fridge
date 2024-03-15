import 'package:fridge/auth/data/datasource/auth_local_data_source.dart';
import 'package:fridge/auth/data/datasource/auth_remote_data_source.dart';
import 'package:fridge/auth/data/repository/auth_repository_impl.dart';
import 'package:fridge/auth/domain/repository/auth_repository.dart';
import 'package:fridge/auth/domain/usecases/is_first_entry_usecase.dart';
import 'package:fridge/auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:fridge/auth/domain/usecases/login_usecase.dart';
import 'package:fridge/auth/domain/usecases/register_usecase.dart';
import 'package:fridge/auth/domain/usecases/sign_out_usecase.dart';
import 'package:fridge/core/network/dio_manager.dart';
import 'package:fridge/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/presentation/bloc/auth_bloc.dart';

final instance = GetIt.instance;

class ServicesLocator {
  Future<void> init() async {

    /// Shared Preferences
    instance.registerSingletonAsync<SharedPreferences>(
            () => SharedPreferences.getInstance()
    );
    await GetIt.instance.isReady<SharedPreferences>();

    /// Bloc
    instance.registerFactory(() => AuthBloc(
        instance<LoginUsecase>(),
        instance<RegisterUsecase>(),
        instance<SignOutUsecase>(),
        instance<IsLoggedInUsecase>(),
        instance<IsFirstEntryUsecase>(),
    ));
    instance.registerLazySingleton(() => OnboardingBloc());

    /// Use Cases
    instance.registerLazySingleton(() => LoginUsecase(instance<AuthRepository>()));
    instance.registerLazySingleton(() => RegisterUsecase(instance<AuthRepository>()));
    instance.registerLazySingleton(() => SignOutUsecase(instance<AuthRepository>()));
    instance.registerLazySingleton(() => IsLoggedInUsecase(instance<AuthRepository>()));
    instance.registerLazySingleton(() => IsFirstEntryUsecase(instance<AuthRepository>()));

    /// Repository
    instance.registerLazySingleton<AuthRepository>(
            () => AuthRepositoryImpl(instance<AuthLocalDataSource>(), instance<AuthRemoteDataSource>()));

    /// DATA SOURCE
    instance.registerLazySingleton<AuthRemoteDataSource>(
            () => AuthRemoteDataSourceImpl(DioManager.instance));
    instance.registerLazySingleton<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(instance<SharedPreferences>())
    );
  }
}