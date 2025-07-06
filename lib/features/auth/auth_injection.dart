import 'package:vision_app/core/di_storage_listner/di.dart';
import 'package:vision_app/features/auth/data/auth_datasource.dart';
import 'package:vision_app/features/auth/data/auth_repository_impl.dart';
import 'package:vision_app/features/auth/domain/auth_repository.dart';
import 'package:vision_app/features/auth/domain/use_cases/get_current_user_usecase.dart';
import 'package:vision_app/features/auth/domain/use_cases/sign_in_usecase.dart';
import 'package:vision_app/features/auth/domain/use_cases/sign_up_usecase.dart';
import 'package:vision_app/features/auth/presentation/state_managments/auth_bloc/auth_bloc.dart';
import 'package:vision_app/features/auth/presentation/state_managments/current_user_bloc/current_user_bloc.dart';

Future<void> initAuth() async {
  //remote :
  if (!sl.isRegistered<AuthRemoteDataSource>()) {
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(auth: sl()),
    );
  }
  //________________________________________________________________________
  //repo
  if (!sl.isRegistered<AuthRepository>()) {
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl(), sl()),
    );
  }
  //________________________________________________________________________
  // use case :
  if (!sl.isRegistered<SignUpWithEmailAndPassword>()) {
    sl.registerFactory(() => SignUpWithEmailAndPassword(sl()));
  }

  if (!sl.isRegistered<SignInWithEmailAndPassword>()) {
    sl.registerFactory(() => SignInWithEmailAndPassword(sl()));
  }

  if (!sl.isRegistered<GetCurrentUserUseCase>()) {
    sl.registerFactory(() => GetCurrentUserUseCase(sl()));
  }
  //________________________________________________________________________
  //bloc :
  if (!sl.isRegistered<AuthBloc>()) {
    sl.registerFactory(
      () => AuthBloc(
        signInWithEmailAndPassword: sl(),
        signUpWithEmailAndPassword: sl(),
      ),
    );
  }

  if (!sl.isRegistered<CurrentUserBloc>()) {
    sl.registerFactory(() => CurrentUserBloc(getCurrentUserUseCase: sl()));
  }
}


//!! it get problems here !? even in the use case : Type SignUpWithEmailAndPassword is already registered inside GetIt.