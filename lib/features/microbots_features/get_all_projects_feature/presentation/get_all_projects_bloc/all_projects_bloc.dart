import 'package:bloc/bloc.dart';
import 'package:vision_app/core/shared/entities/project_entities/project_entity.dart';
import 'package:vision_app/features/microbots_features/get_all_projects_feature/domain/get_all_projects_usecase.dart';

part 'all_projects_event.dart';
part 'all_projects_state.dart';

class AllProjectsBloc extends Bloc<AllProjectsEvent, AllProjectsState> {
  final GetAllProjectsUsecase getAllProjectsUsecase;
  AllProjectsBloc(this.getAllProjectsUsecase) : super(AllProjectsInitial()) {
    on<FetchAllProjects>((event, emit) async {
      emit(AllProjectsLoading());
      final res = await getAllProjectsUsecase.call();
      res.fold(
        (failure) => emit(AllProjectsFailure(failure.message)),
        (projects) => emit(AllProjectsSuccess(projects)),
      );
    });
  }
}
