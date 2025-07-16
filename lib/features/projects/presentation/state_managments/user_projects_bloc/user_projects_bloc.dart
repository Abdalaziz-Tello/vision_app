import 'package:bloc/bloc.dart';
import 'package:vision_app/features/projects/domain/entities/project_entity.dart';
import 'package:vision_app/features/projects/domain/usecase/get_projects_by_userid_usecase.dart';

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
