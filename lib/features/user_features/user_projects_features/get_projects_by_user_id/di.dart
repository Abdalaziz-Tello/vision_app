import 'package:vision_app/core/di_storage_listner/di.dart';
import 'package:vision_app/features/user_features/user_projects_features/get_projects_by_user_id/data/get_projects_by_use_id_repo_imp.dart';
import 'package:vision_app/features/user_features/user_projects_features/get_projects_by_user_id/data/remote_get_projects_by_use_id_datasource.dart';
import 'package:vision_app/features/user_features/user_projects_features/get_projects_by_user_id/domain/get_projects_by_user_id_repo.dart';
import 'package:vision_app/features/user_features/user_projects_features/get_projects_by_user_id/domain/get_projects_by_userid_usecase.dart';
import 'package:vision_app/features/user_features/user_projects_features/get_projects_by_user_id/presentation/user_projects_bloc/user_projects_bloc.dart';

Future<void> initGetProjectsByUserId() async {
  //remote :

  if (!sl.isRegistered<RemoteGetProjectsByUseIdDatasource>()) {
    sl.registerLazySingleton<RemoteGetProjectsByUseIdDatasource>(
      () => RemoteGetProjectsByUseIdDatasourceImp(supabaseService: sl()),
    );
  }

  //__________________________________________________________
  //repo:

  if (!sl.isRegistered<GetProjectsByUserIdRepo>()) {
    sl.registerLazySingleton<GetProjectsByUserIdRepo>(
      () =>
          GetProjectsByUseIdRepoImp(remoteDataSource: sl(), networkInfo: sl()),
    );
  }
  //__________________________________________________________
  //usecase :
  if (!sl.isRegistered<GetProjectsByUseridUsecase>()) {
    sl.registerFactory(() => GetProjectsByUseridUsecase(sl()));
  }

  //__________________________________________________________
  //bloc :
  if (!sl.isRegistered<UserProjectsBloc>()) {
    sl.registerFactory(() => UserProjectsBloc(sl()));
  }
}
