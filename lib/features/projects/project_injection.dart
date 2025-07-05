import 'package:vision_app/core/storage/di.dart';
import 'package:vision_app/features/projects/data/datasource/project_remote_datasource.dart';
import 'package:vision_app/features/projects/data/repo/project_repositoryImpl.dart';
import 'package:vision_app/features/projects/domain/repo/project_repository.dart';
import 'package:vision_app/features/projects/domain/usecase/create_project_usecase.dart';
import 'package:vision_app/features/projects/domain/usecase/get_all_project_domains_usecase.dart';
import 'package:vision_app/features/projects/domain/usecase/get_project_details_usecase.dart';
import 'package:vision_app/features/projects/domain/usecase/upload_file_usecase.dart';
import 'package:vision_app/features/projects/presentation/create_project_bloc/create_project_bloc.dart';
import 'package:vision_app/features/projects/presentation/project_details_bloc/project_details_bloc.dart';
import 'package:vision_app/features/projects/presentation/project_domains_bloc/project_domains_bloc.dart';
import 'package:vision_app/features/projects/presentation/upload_file_bloc/upload_file_bloc.dart';

Future<void> initProject() async {
  //remote :
  if (!sl.isRegistered<ProjectRemoteDataSource>()) {
    sl.registerLazySingleton<ProjectRemoteDataSource>(
      () => ProjectDomainRemoteDataSourceImpl(supabase: sl()),
    );
  }
  //?___________________________________________________________
  //repo :
  if (!sl.isRegistered<ProjectRepository>()) {
    sl.registerLazySingleton<ProjectRepository>(
      () => ProjectRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
    );
  }
  //?___________________________________________________________
  //Usecase :
  if (!sl.isRegistered<GetAllProjectDomainsUseCase>()) {
    sl.registerFactory(() => GetAllProjectDomainsUseCase(sl()));
  }

  //_________
  if (!sl.isRegistered<CreateProjectUseCase>()) {
    sl.registerFactory(() => CreateProjectUseCase(sl()));
  }
  //__________
  if (!sl.isRegistered<UploadFileUseCase>()) {
    sl.registerFactory(() => UploadFileUseCase(sl()));
  }

  if (!sl.isRegistered<GetProjectDetailsUseCase>()) {
    sl.registerFactory(() => GetProjectDetailsUseCase(sl()));
  }
  //?___________________________________________________________
  //BLOC :
  if (!sl.isRegistered<ProjectDomainsBloc>()) {
    sl.registerFactory(() => ProjectDomainsBloc(getAllProjectDomains: sl()));
  }
  //__________
  if (!sl.isRegistered<CreateProjectBloc>()) {
    sl.registerFactory(() => CreateProjectBloc(createProjectUseCase: sl()));
  }

  if (!sl.isRegistered<UploadFileBloc>()) {
    sl.registerFactory(() => UploadFileBloc(uploadFileUseCase: sl()));
  }

  if (!sl.isRegistered<ProjectDetailsBloc>()) {
    sl.registerFactory(() => ProjectDetailsBloc(getUseCase: sl()));
  }
}
