import 'package:vision_app/core/di_storage_listner/di.dart';
import 'package:vision_app/features/microbots_features/get_all_projects_feature/data/get_all_projects_remote_datasource.dart';
import 'package:vision_app/features/microbots_features/get_all_projects_feature/data/get_all_projects_repo_imp.dart';
import 'package:vision_app/features/microbots_features/get_all_projects_feature/domain/get_all_projects_repo.dart';
import 'package:vision_app/features/microbots_features/get_all_projects_feature/domain/get_all_projects_usecase.dart';
import 'package:vision_app/features/microbots_features/get_all_projects_feature/presentation/get_all_projects_bloc/all_projects_bloc.dart';

Future<void> initGetAllProjects() async {
  //remote :

  if (!sl.isRegistered<GetAllProjectsRemoteDatasource>()) {
    sl.registerLazySingleton<GetAllProjectsRemoteDatasource>(
      () => GetAllProjectsRemoteDatasourceImp(supabase: sl()),
    );
  }
  //___________________________________________________________
  // repo :

  if (!sl.isRegistered<GetAllProjectsRepo>()) {
    sl.registerLazySingleton<GetAllProjectsRepo>(
      () => GetAllProjectsRepoImp(remoteDataSource: sl(), networkInfo: sl()),
    );
  }
  //___________________________________________________________
  //use case :
  if (!sl.isRegistered<GetAllProjectsUsecase>()) {
    sl.registerFactory(() => GetAllProjectsUsecase(sl()));
  }

  //___________________________________________________________

  //bloc :
  if (!sl.isRegistered<AllProjectsBloc>()) {
    sl.registerFactory(() => AllProjectsBloc(sl()));
  }
}
