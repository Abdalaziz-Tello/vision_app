part of 'project_details_bloc.dart';

abstract class ProjectDetailsState {}

class ProjectDetailsInitial extends ProjectDetailsState {}

class ProjectDetailsLoading extends ProjectDetailsState {}

class ProjectDetailsSuccess extends ProjectDetailsState {
  final ProjectEntity project;
  ProjectDetailsSuccess(this.project);
}

class ProjectDetailsFailure extends ProjectDetailsState {
  final String error;
  ProjectDetailsFailure(this.error);
}
