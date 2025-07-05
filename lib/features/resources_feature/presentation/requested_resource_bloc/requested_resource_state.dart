part of 'requested_resource_bloc.dart';

abstract class ResourceState {}

class ResourceInitial extends ResourceState {}

class ResourceLoading extends ResourceState {}

class ResourceSuccess extends ResourceState {
  final List<RequestedResourceEntity> resources;

  ResourceSuccess(this.resources);
}

class ResourceFailure extends ResourceState {
  final String message;

  ResourceFailure(this.message);
}
