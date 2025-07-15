part of 'create_project_bloc.dart';

abstract class CreateProjectEvent {}

class CreateProjectRequested extends CreateProjectEvent {
  final CreateProjectEntity entity;

  CreateProjectRequested(this.entity);
}
