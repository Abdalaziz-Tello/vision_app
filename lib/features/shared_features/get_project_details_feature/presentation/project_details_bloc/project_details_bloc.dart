import 'package:bloc/bloc.dart';
import 'package:vision_app/core/shared/entities/project_entities/project_entity.dart';
import 'package:vision_app/features/shared_features/get_project_details_feature/domain/get_project_details_usecase.dart';

part 'project_details_event.dart';
part 'project_details_state.dart';

class ProjectDetailsBloc
    extends Bloc<ProjectDetailsEvent, ProjectDetailsState> {
  final GetProjectDetailsUseCase getUseCase;

  ProjectDetailsBloc({required this.getUseCase})
    : super(ProjectDetailsInitial()) {
    on<FetchProjectDetails>(_onFetch);
  }

  Future<void> _onFetch(
    FetchProjectDetails event,
    Emitter<ProjectDetailsState> emit,
  ) async {
    emit(ProjectDetailsLoading());
    final res = await getUseCase(event.projectId);
    res.fold(
      (f) => emit(ProjectDetailsFailure(f.message)),
      (pro) => emit(ProjectDetailsSuccess(pro)),
    );
  }
}
