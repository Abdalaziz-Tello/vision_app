import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/features/resources_feature/domain/entity/resource_request_entity.dart';
import 'package:vision_app/features/resources_feature/domain/resources_repo.dart';

class GetUsersResourceRequest {
  final ResourcesRepo repository;

  GetUsersResourceRequest(this.repository);

  Future<Either<Failure, List<ResourceRequestEntity>>> call({
    String? departmentId,
  }) {
    return repository.getUsersResourcesRequest();
  }
}
