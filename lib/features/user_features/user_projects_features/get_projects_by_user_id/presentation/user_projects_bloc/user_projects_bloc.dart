import 'package:bloc/bloc.dart';
import 'package:vision_app/core/shared/entities/project_entities/project_entity.dart';
import 'package:vision_app/features/user_features/user_projects_features/get_projects_by_user_id/domain/get_projects_by_userid_usecase.dart';

part 'user_projects_event.dart';
part 'user_projects_state.dart';

class UserProjectsBloc extends Bloc<UserProjectsEvent, UserProjectsState> {
  final GetProjectsByUseridUsecase getProjectsByUseridUsecase;

  UserProjectsBloc(this.getProjectsByUseridUsecase)
    : super(UserProjectsInitial()) {
    on<LoadUserProjects>((event, emit) async {
      emit(UserProjectsLoading());
      final res = await getProjectsByUseridUsecase.call(event.userId);
      res.fold(
        (failure) => emit(UserProjectsError(failure.message)),
        (projects) => emit(UserProjectsLoaded(projects)),
      );
    });
  }
}
