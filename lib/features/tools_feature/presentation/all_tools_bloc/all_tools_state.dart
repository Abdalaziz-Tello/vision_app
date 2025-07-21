part of 'all_tools_bloc.dart';

abstract class AllToolsState {}

class AllToolsInitial extends AllToolsState {}

class AllToolsLoading extends AllToolsState {}

class AllToolsSuccess extends AllToolsState {
  final List<ToolsEntity> tools;

  AllToolsSuccess(this.tools);
}

class AllToolsFailure extends AllToolsState {
  final String error;

  AllToolsFailure(this.error);
}
