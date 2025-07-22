import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/domain/entities/create_project_entity.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/domain/usecase/create_project_usecase.dart';

part 'create_project_event.dart';
part 'create_project_state.dart';

class CreateProjectBloc extends Bloc<CreateProjectEvent, CreateProjectState> {
  final CreateProjectUseCase createProjectUseCase;

  CreateProjectBloc({required this.createProjectUseCase})
    : super(CreateProjectInitial()) {
    on<CreateProjectRequested>(_onCreateProjectRequested);
  }

  Future<void> _onCreateProjectRequested(
    CreateProjectRequested event,
    Emitter<CreateProjectState> emit,
  ) async {
    emit(CreateProjectLoading());

    final result = await createProjectUseCase(event.entity);

    result.fold(
      (failure) => emit(CreateProjectFailure(failure.message)),
      (projectId) => emit(CreateProjectSuccess(projectId)),
    );
  }
}
