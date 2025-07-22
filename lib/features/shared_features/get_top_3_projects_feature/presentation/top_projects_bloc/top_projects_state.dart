part of 'top_projects_bloc.dart';

abstract class TopProjectsState {}

class TopProjectsInitial extends TopProjectsState {}

class TopProjectsLoading extends TopProjectsState {}

class TopProjectsSuccess extends TopProjectsState {
  final List<ProjectEntity> projects;

  TopProjectsSuccess(this.projects);
}

class TopProjectsFailure extends TopProjectsState {
  final String error;

  TopProjectsFailure(this.error);
}
