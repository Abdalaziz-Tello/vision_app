part of 'requested_resource_bloc.dart';

abstract class ResourceEvent {}

class FetchRequestedResources extends ResourceEvent {
  final String? departmentId;

  FetchRequestedResources({this.departmentId});
}
