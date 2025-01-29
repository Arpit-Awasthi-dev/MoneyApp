import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:money_app/data/data_sources/local_data_sources/auth_local_data_source.dart';
import 'package:money_app/data/data_sources/remote_data_sources/auth_remote_data_source.dart';
import 'package:money_app/data/data_sources/remote_data_sources/money_remote_data_source.dart';
import 'package:money_app/data/repo_impl/auth_repo_impl.dart';
import 'package:money_app/data/repo_impl/money_repo_impl.dart';
import 'package:money_app/domain/repositories/auth_repo.dart';
import 'package:money_app/domain/repositories/money_repo.dart';
import 'package:money_app/domain/usecases/add_money_use_case.dart';
import 'package:money_app/domain/usecases/get_transaction_history_use_case.dart';
import 'package:money_app/domain/usecases/get_user_balance_use_case.dart';
import 'package:money_app/domain/usecases/logout_use_case.dart';
import 'package:money_app/domain/usecases/send_money_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data_sources/local_data_sources/money_local_data_source.dart';
import '../domain/usecases/get_user_auth_status_use_case.dart';
import '../domain/usecases/login_user_use_case.dart';
import '../presentation/cubits/home_page/home_page_cubit.dart';
import '../presentation/cubits/login_page/login_page_cubit.dart';
import '../presentation/cubits/send_add_money_page/send_add_money_page_cubit.dart';
import '../presentation/cubits/transaction_history_page/transaction_history_page_cubit.dart';
import '../presentation/cubits/user/user_cubit.dart';
import 'app_config.dart';
import 'db/database_service.dart';
import 'navigation/navigation_service.dart';
import 'network/api_service.dart';
import 'network/network_info.dart';

//Service locator instance
final sl = GetIt.instance;

Future<void> init() async {
  /// ---------- Cubits ------------
  sl.registerLazySingleton(() => UserCubit(
        getUserAuthStatusUseCase: sl(),
        logOutUseCase: sl(),
      ));
  sl.registerFactory(() => LoginPageCubit(loginUserUseCase: sl()));
  sl.registerFactory(() => HomePageCubit(getUserBalanceUseCase: sl()));
  sl.registerFactory(() => SendAddMoneyPageCubit(
        getUserBalanceUseCase: sl(),
        sendMoneyUseCase: sl(),
        addMoneyUseCase: sl(),
      ));
  sl.registerFactory(() => TransactionHistoryPageCubit(
        getTransactionHistoryUseCase: sl(),
      ));

  /// ----------- Use Cases ----------
  sl.registerLazySingleton(() => GetUserAuthStatusUseCase(repository: sl()));
  sl.registerLazySingleton(() => LoginUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUserBalanceUseCase(repository: sl()));
  sl.registerLazySingleton(() => SendMoneyUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddMoneyUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => GetTransactionHistoryUseCase(repository: sl()));
  sl.registerLazySingleton(() => LogoutUseCase(repository: sl()));

  /// ----------- Repositories -----------
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
        networkInfo: sl(),
        remoteDataSource: sl(),
        localDataSource: sl(),
        moneyLocalDataSource: sl()),
  );

  sl.registerLazySingleton<MoneyRepo>(
    () => MoneyRepoImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  /// ----------- Data Sources ----------
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(db: sl()),
  );
  sl.registerLazySingleton<MoneyRemoteDataSource>(
    () => MoneyRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<MoneyLocalDataSource>(
    () => MoneyLocalDataSourceImpl(db: sl()),
  );

  /// ------------ Others -------------
  sl.registerLazySingleton(() => NavigationService());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => DatabaseService.instance);

  /// ---------- Network ------------
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(
    () => ApiService(
      baseUrl: AppConfig.instance!.apiBaseURL,
      client: sl.get(instanceName: 'api'),
    ),
  );

  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton(
      () => InterceptedClient.build(
            interceptors: [],
            requestTimeout: const Duration(seconds: 10),
          ),
      instanceName: 'api');

  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}
