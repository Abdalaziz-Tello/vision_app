part of 'all_projects_bloc.dart';

abstract class AllProjectsState {}

class AllProjectsInitial extends AllProjectsState {}

class AllProjectsLoading extends AllProjectsState {}

class AllProjectsSuccess extends AllProjectsState {
  final List<ProjectEntity> projects;

  AllProjectsSuccess(this.projects);
}

class AllProjectsFailure extends AllProjectsState {
  final String error;

  AllProjectsFailure(this.error);
}
