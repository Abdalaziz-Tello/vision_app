part of 'project_details_bloc.dart';

abstract class ProjectDetailsEvent {}

class FetchProjectDetails extends ProjectDetailsEvent {
  final String projectId;
  FetchProjectDetails(this.projectId);
}
