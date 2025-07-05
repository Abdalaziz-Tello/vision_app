part of 'resource_request_bloc.dart';

abstract class ResourceRequestState {
  const ResourceRequestState();
}

class ResourceRequestInitial extends ResourceRequestState {}

class ResourceRequestLoading extends ResourceRequestState {}

class ResourceRequestSuccess extends ResourceRequestState {}

class ResourceRequestFailure extends ResourceRequestState {
  final String message;

  const ResourceRequestFailure(this.message);
}
