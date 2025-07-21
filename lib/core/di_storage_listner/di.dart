import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vision_app/core/network/network_info.dart';
import 'package:vision_app/core/res/keys/app_keys.dart';
import 'package:vision_app/core/di_storage_listner/user_id.dart';
import 'package:vision_app/features/auth/utils/auth_injection.dart';
import 'package:vision_app/features/projects/project_injection.dart';
import 'package:vision_app/features/resources_feature/resources_di.dart';
import 'package:vision_app/features/tools_feature/tools_injuction.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core dependencies
  await _initCore();
  //feautres :
  await initAuth();
  await initProject();
  await initResources();
  await initTools();
}

Future<void> _initCore() async {
  if (!sl.isRegistered<SupabaseClient>()) {
    await Supabase.initialize(
      url: AppKeys.supabaseUrl,
      anonKey: AppKeys.supabaseAnonKey,
      authOptions: FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
        autoRefreshToken: true,
        detectSessionInUri: true,
        // localStorage: LocalStorageWeb(),
        // pkceAsyncStorage: PkceAsyncStorageWeb(),
      ),
    );
    sl.registerLazySingleton(() => Supabase.instance.client);
  }
  if (!sl.isRegistered<GoTrueClient>()) {
    sl.registerLazySingleton(() => sl<SupabaseClient>().auth);
  }

  if (!sl.isRegistered<InternetConnectionChecker>()) {
    sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
  }

  if (!sl.isRegistered<NetworkInfo>()) {
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  }

  //To get the id :
  if (!sl.isRegistered<UserSession>()) {
    sl.registerLazySingleton(() => UserSession(sl<GoTrueClient>()));
  }
}
