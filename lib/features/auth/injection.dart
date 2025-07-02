import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vision_app/core/network/network_info.dart';
import 'package:vision_app/core/res/app_keys.dart';
import 'package:vision_app/features/auth/data/auth_datasource.dart';
import 'package:vision_app/features/auth/data/auth_repository_impl.dart';
import 'package:vision_app/features/auth/domain/auth_repository.dart';
import 'package:vision_app/features/auth/domain/use_cases/sign_in_usecase.dart';
import 'package:vision_app/features/auth/domain/use_cases/sign_up_usecase.dart';

final sl = GetIt.instance;
bool _supabaseInitialized = false; //TODO : search for better way

Future<void> init() async {
  //supabase :

  // await Supabase.initialize(
  //   url: AppKeys.supabaseUrl,
  //   anonKey: AppKeys.supabaseAnonKey,
  // );

  if (!_supabaseInitialized) {
    await Supabase.initialize(
      url: AppKeys.supabaseUrl,
      anonKey: AppKeys.supabaseAnonKey,
    );
    _supabaseInitialized = true;
  }

  // Register the auth instance directly
  if (!sl.isRegistered<GoTrueClient>()) {
    sl.registerLazySingleton<GoTrueClient>(() => Supabase.instance.client.auth);
  }
  //_________________________________________________________________

  if (!sl.isRegistered<InternetConnectionChecker>()) {
    sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
  }

  if (!sl.isRegistered<NetworkInfo>()) {
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  }

  //_________________________________________________________________
  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(auth: sl()),
  );

  //_________________________________________________________________
  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );

  //_________________________________________________________________
  // Use case
  sl.registerFactory(() => SignUpWithEmailAndPassword(sl()));
  sl.registerFactory(() => SignInWithEmailAndPassword(sl()));
}
