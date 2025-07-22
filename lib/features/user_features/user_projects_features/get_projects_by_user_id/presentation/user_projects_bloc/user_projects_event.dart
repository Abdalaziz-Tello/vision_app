part of 'user_projects_bloc.dart';

abstract class UserProjectsEvent {}

class LoadUserProjects extends UserProjectsEvent {
  final String userId;

  LoadUserProjects(this.userId);
}
