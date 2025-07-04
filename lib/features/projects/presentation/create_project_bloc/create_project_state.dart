part of 'create_project_bloc.dart';

abstract class CreateProjectState {}

class CreateProjectInitial extends CreateProjectState {}

class CreateProjectLoading extends CreateProjectState {}

class CreateProjectSuccess extends CreateProjectState {
  final String projectId;

  CreateProjectSuccess(this.projectId);
}

class CreateProjectFailure extends CreateProjectState {
  final String error;

  CreateProjectFailure(this.error);
}
