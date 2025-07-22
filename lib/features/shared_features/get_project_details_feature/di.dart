import 'package:vision_app/core/di_storage_listner/di.dart';
import 'package:vision_app/features/shared_features/get_project_details_feature/data/get_project_details_repo_imp.dart';
import 'package:vision_app/features/shared_features/get_project_details_feature/data/remote_get_poject_details.dart';
import 'package:vision_app/features/shared_features/get_project_details_feature/domain/get_project_details_repository.dart';
import 'package:vision_app/features/shared_features/get_project_details_feature/domain/get_project_details_usecase.dart';
import 'package:vision_app/features/shared_features/get_project_details_feature/presentation/project_details_bloc/project_details_bloc.dart';

Future<void> initProjectDetails() async {
  //remote :
  if (!sl.isRegistered<RemoteGetPojectDetails>()) {
    sl.registerLazySingleton<RemoteGetPojectDetails>(
      () => RemoteGetPojectDetailsImpl(supabase: sl()),
    );
  }
  //_____________________________________________________________
  //repo :
  if (!sl.isRegistered<GetProjectDetailsRepository>()) {
    sl.registerLazySingleton<GetProjectDetailsRepository>(
      () => GetProjectDetailsRepoImp(remoteDataSource: sl(), networkInfo: sl()),
    );
  }
  //_____________________________________________________________
  //use case :
  if (!sl.isRegistered<GetProjectDetailsUseCase>()) {
    sl.registerFactory(() => GetProjectDetailsUseCase(sl()));
  }
  //_____________________________________________________________
  //bloc :
  if (!sl.isRegistered<ProjectDetailsBloc>()) {
    sl.registerFactory(() => ProjectDetailsBloc(getUseCase: sl()));
  }
}
