part of 'user_projects_bloc.dart';

abstract class UserProjectsState {}

class UserProjectsInitial extends UserProjectsState {}

class UserProjectsLoading extends UserProjectsState {}

class UserProjectsLoaded extends UserProjectsState {
  final List<ProjectEntity> projects;

  UserProjectsLoaded(this.projects);
}

class UserProjectsError extends UserProjectsState {
  final String message;

  UserProjectsError(this.message);
}
