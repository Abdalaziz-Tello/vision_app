import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/core/shared/entities/resources_entity/resource_request_entity.dart';
import 'package:vision_app/features/microbots_features/get_resource_requests/domain/get_users_resource_requests_repo.dart';

class GetUsersResourceRequest {
  final GetUsersResourceRequestsRepo repository;

  GetUsersResourceRequest(this.repository);

  Future<Either<Failure, List<ResourceRequestEntity>>> call({
    String? departmentId,
  }) {
    return repository.getUsersResourcesRequest();
  }
}
