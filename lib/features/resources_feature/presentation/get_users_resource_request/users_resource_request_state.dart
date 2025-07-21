part of 'users_resource_request_bloc.dart';

abstract class UsersResourceRequestState {}

class UsersResourceRequestInitial extends UsersResourceRequestState {}

class UsersResourceRequestLoading extends UsersResourceRequestState {}

class UsersResourceRequestSuccess extends UsersResourceRequestState {
  final List<ResourceRequestEntity> resources;

  UsersResourceRequestSuccess(this.resources);
}

class UsersResourceRequestFailure extends UsersResourceRequestState {
  final String message;

  UsersResourceRequestFailure(this.message);
}
