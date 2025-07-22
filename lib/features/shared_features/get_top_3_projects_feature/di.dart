import 'package:vision_app/core/di_storage_listner/di.dart';
import 'package:vision_app/features/shared_features/get_top_3_projects_feature/data/get_top_completed_project_repo_imp.dart';
import 'package:vision_app/features/shared_features/get_top_3_projects_feature/data/top_completed_project_datasource.dart';
import 'package:vision_app/features/shared_features/get_top_3_projects_feature/domain/get_top_completed_projects_repo.dart';
import 'package:vision_app/features/shared_features/get_top_3_projects_feature/domain/get_top_completed_projects_usecase.dart';
import 'package:vision_app/features/shared_features/get_top_3_projects_feature/presentation/top_projects_bloc/top_projects_bloc.dart';

Future<void> initTopCompletedProjects() async {
  //remote :

  if (!sl.isRegistered<TopCompletedProjectDatasource>()) {
    sl.registerLazySingleton<TopCompletedProjectDatasource>(
      () => TopCompletedProjectDatasourceImp(supabase: sl()),
    );
  }
  //_____________________________________________________________
  //repo :
  if (!sl.isRegistered<GetTopCompletedProjectsRepo>()) {
    sl.registerLazySingleton<GetTopCompletedProjectsRepo>(
      () => GetTopCompletedProjectsRepoImp(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ),
    );
  }
  //_____________________________________________________________
  //usecase :
  if (!sl.isRegistered<GetTopCompletedProjectsUseCase>()) {
    sl.registerFactory(() => GetTopCompletedProjectsUseCase(sl()));
  }
  //_____________________________________________________________
  //bloc :

  if (!sl.isRegistered<TopProjectsBloc>()) {
    sl.registerFactory(() => TopProjectsBloc(getUseCase: sl()));
  }

  //_____________________________________________________________
}
