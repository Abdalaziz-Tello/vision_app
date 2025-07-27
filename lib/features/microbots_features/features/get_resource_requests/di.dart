import 'package:vision_app/core/di_storage_listner/di.dart';
import 'package:vision_app/features/microbots_features/features/get_resource_requests/data/get_users_resource_requests_repo_imp.dart';
import 'package:vision_app/features/microbots_features/features/get_resource_requests/data/remote_get_users_resource_datasource.dart';
import 'package:vision_app/features/microbots_features/features/get_resource_requests/domain/get_users_resource_request.dart';
import 'package:vision_app/features/microbots_features/features/get_resource_requests/domain/get_users_resource_requests_repo.dart';
import 'package:vision_app/features/microbots_features/features/get_resource_requests/presentation/get_users_resource_request/users_resource_request_bloc.dart';

Future<void> initGetAllResourceRequests() async {
  //remote :
  if (!sl.isRegistered<RemoteGetUsersResourceDatasource>()) {
    sl.registerLazySingleton<RemoteGetUsersResourceDatasource>(
      () => RemoteGetUsersResourceDatasourceImp(supabase: sl()),
    );
  }

  //________________________________________________________
  // Repository
  if (!sl.isRegistered<GetUsersResourceRequestsRepo>()) {
    sl.registerLazySingleton<GetUsersResourceRequestsRepo>(
      () => GetUsersResourceRequestsRepoImp(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ),
    );
  }

  //________________________________________________________
  //usecase :
  if (!sl.isRegistered<GetUsersResourceRequest>()) {
    sl.registerFactory(() => GetUsersResourceRequest(sl()));
  }
  //________________________________________________________
  //bloc :
  if (!sl.isRegistered<UsersResourceRequestBloc>()) {
    sl.registerFactory(
      () => UsersResourceRequestBloc(getUsersResourceRequest: sl()),
    );
  }
}
