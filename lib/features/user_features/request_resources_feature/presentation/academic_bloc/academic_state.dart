part of 'academic_bloc.dart';

abstract class AcademicState {}

class AcademicInitial extends AcademicState {}

class AcademicLoading extends AcademicState {}

class AcademicSuccess extends AcademicState {
  final List<AcademicDepartmentsEntity> academics;

  AcademicSuccess(this.academics);
}

class AcademicFailure extends AcademicState {
  final String message;

  AcademicFailure(this.message);
}
