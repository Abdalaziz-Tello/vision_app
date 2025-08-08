import 'package:vision_app/core/di_storage_listner/di.dart';
import 'package:vision_app/features/user_features/request_resources_feature/data/remote_resources.dart';
import 'package:vision_app/features/user_features/request_resources_feature/data/resources_repo_imp.dart';
import 'package:vision_app/features/user_features/request_resources_feature/domain/usecase/get_all_academics_usecase.dart';
import 'package:vision_app/features/user_features/request_resources_feature/domain/resources_repo.dart';
import 'package:vision_app/features/user_features/request_resources_feature/domain/usecase/get_requested_resources_usecase.dart';
import 'package:vision_app/features/user_features/request_resources_feature/domain/usecase/submit_resource_request_usecase.dart';
import 'package:vision_app/features/user_features/request_resources_feature/presentation/academic_bloc/academic_bloc.dart';
import 'package:vision_app/features/user_features/request_resources_feature/presentation/requested_resource_bloc/requested_resource_bloc.dart';
import 'package:vision_app/features/user_features/request_resources_feature/presentation/resource_request_bloc/resource_request_bloc.dart';

Future<void> initResources() async {
  // Remote
  if (!sl.isRegistered<RemoteResources>()) {
    sl.registerLazySingleton<RemoteResources>(
      () => RemoteResourcesImpl(supabaseService: sl()),
    );
  }
  //________________________________________________________

  // Repository
  if (!sl.isRegistered<ResourcesRepo>()) {
    sl.registerLazySingleton<ResourcesRepo>(
      () => ResourcesRepoImp(remoteDataSource: sl(), networkInfo: sl()),
    );
  }
  //________________________________________________________

  // UseCase
  if (!sl.isRegistered<GetAllAcademicsUseCase>()) {
    sl.registerFactory(() => GetAllAcademicsUseCase(sl()));
  }

  if (!sl.isRegistered<GetRequestedResourcesUseCase>()) {
    sl.registerFactory(() => GetRequestedResourcesUseCase(sl()));
  }

  if (!sl.isRegistered<SubmitResourceRequestUseCase>()) {
    sl.registerFactory(() => SubmitResourceRequestUseCase(sl()));
  }

  // if (!sl.isRegistered<GetUsersResourceRequest>()) {
  //   sl.registerFactory(() => GetUsersResourceRequest(sl()));
  // }

  //________________________________________________________
  // Bloc
  if (!sl.isRegistered<AcademicBloc>()) {
    sl.registerFactory(() => AcademicBloc(sl()));
  }

  if (!sl.isRegistered<ResourceBloc>()) {
    sl.registerFactory(() => ResourceBloc(sl()));
  }

  if (!sl.isRegistered<ResourceRequestBloc>()) {
    sl.registerFactory(() => ResourceRequestBloc(sl()));
  }

  // if (!sl.isRegistered<UsersResourceRequestBloc>()) {
  //   sl.registerFactory(
  //     () => UsersResourceRequestBloc(getUsersResourceRequest: sl()),
  //   );
  // }
}
