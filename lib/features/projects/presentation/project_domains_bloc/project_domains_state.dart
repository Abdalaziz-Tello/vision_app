part of 'project_domains_bloc.dart';

abstract class ProjectDomainsState {}

class ProjectDomainsInitial extends ProjectDomainsState {}

class ProjectDomainsLoading extends ProjectDomainsState {}

class ProjectDomainsSuccess extends ProjectDomainsState {
  final List<ProjectDomainsEntity> domains;

  ProjectDomainsSuccess({required this.domains});
}

class ProjectDomainsFailure extends ProjectDomainsState {
  final String message;

  ProjectDomainsFailure(this.message);
}
