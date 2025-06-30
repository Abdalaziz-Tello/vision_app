import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vision_app/core/network/network_info.dart';
import 'package:vision_app/core/res/app_keys.dart';
import 'package:vision_app/features/auth/data/auth_datasource.dart';
import 'package:vision_app/features/auth/data/auth_repository_impl.dart';
import 'package:vision_app/features/auth/domain/auth_repository.dart';
import 'package:vision_app/features/auth/domain/sign_in_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //supabase :
  if (!sl.isRegistered<SupabaseClient>()) {
    sl.registerLazySingleton(
      () => SupabaseClient(AppKeys.supabaseUrl, AppKeys.supabaseAnonKey),
    );
  }

  //_________________________________________________________________

  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  // Data sources
  //_________________________________________________________________
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl()),
  );
  // Repository
  //_________________________________________________________________
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  // Use case
  //_________________________________________________________________
  sl.registerFactory(() => SignInWithEmailAndPassword(sl()));
}
