part of 'resource_request_bloc.dart';

abstract class ResourceRequestEvent {
  const ResourceRequestEvent();
}

class SubmitResourceRequest extends ResourceRequestEvent {
  final ResourceRequestEntity entity;

  const SubmitResourceRequest(this.entity);
}
