import 'package:bloc/bloc.dart';
import 'package:vision_app/features/projects/domain/entities/project_entity.dart';
import 'package:vision_app/features/projects/domain/usecase/get_top_completed_projects_usecase.dart';

part 'top_projects_event.dart';
part 'top_projects_state.dart';

class TopProjectsBloc extends Bloc<TopProjectsEvent, TopProjectsState> {
  final GetTopCompletedProjectsUseCase getUseCase;

  TopProjectsBloc({required this.getUseCase}) : super(TopProjectsInitial()) {
    on<FetchTopProjects>(_onFetch);
  }

  Future<void> _onFetch(
    FetchTopProjects event,
    Emitter<TopProjectsState> emit,
  ) async {
    emit(TopProjectsLoading());

    final res = await getUseCase();
    res.fold(
      (failure) => emit(TopProjectsFailure(failure.message)),
      (projects) => emit(TopProjectsSuccess(projects)),
    );
  }
}
