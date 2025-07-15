import 'package:bloc/bloc.dart';
import 'package:vision_app/features/projects/domain/entities/project_domains_entity.dart';
import 'package:vision_app/features/projects/domain/usecase/get_all_project_domains_usecase.dart';

part 'project_domains_event.dart';
part 'project_domains_state.dart';

class ProjectDomainsBloc
    extends Bloc<ProjectDomainsEvent, ProjectDomainsState> {
  final GetAllProjectDomainsUseCase getAllProjectDomains;

  ProjectDomainsBloc({required this.getAllProjectDomains})
    : super(ProjectDomainsInitial()) {
    on<FetchProjectDomainsRequested>(_onFetchRequested);
  }

  Future<void> _onFetchRequested(
    FetchProjectDomainsRequested event,
    Emitter<ProjectDomainsState> emit,
  ) async {
    emit(ProjectDomainsLoading());

    final result = await getAllProjectDomains();

    result.fold(
      (failure) => emit(ProjectDomainsFailure(failure.message)),
      (domains) => emit(ProjectDomainsSuccess(domains: domains)),
    );
  }
}
