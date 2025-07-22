import 'package:vision_app/core/di_storage_listner/di.dart';
import 'package:vision_app/features/microbots_features/tools_feature/data/remote_tools.dart';
import 'package:vision_app/features/microbots_features/tools_feature/data/tools_repo_imp.dart';
import 'package:vision_app/features/microbots_features/tools_feature/domain/get_all_tools_usecas.dart';
import 'package:vision_app/features/microbots_features/tools_feature/domain/tools_repo.dart';
import 'package:vision_app/features/microbots_features/tools_feature/presentation/all_tools_bloc/all_tools_bloc.dart';

Future<void> initTools() async {
  //remote :
  if (!sl.isRegistered<ToolsRemoteDataSource>()) {
    sl.registerLazySingleton<ToolsRemoteDataSource>(
      () => ToolsRemoteDataSourceImpl(supabase: sl()),
    );
  }
  //___________________________________________________________
  //repo :
  if (!sl.isRegistered<ToolsRepository>()) {
    sl.registerLazySingleton<ToolsRepository>(
      () => ToolsRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
    );
  }
  //___________________________________________________________

  //Usecase :
  if (!sl.isRegistered<GetAllToolsUsecase>()) {
    sl.registerFactory(() => GetAllToolsUsecase(sl()));
  }
  //___________________________________________________________

  //BLOC :
  if (!sl.isRegistered<AllToolsBloc>()) {
    sl.registerFactory(() => AllToolsBloc(sl()));
  }
}
