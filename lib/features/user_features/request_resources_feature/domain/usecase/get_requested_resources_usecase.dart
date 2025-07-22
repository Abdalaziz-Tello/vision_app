import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/features/user_features/request_resources_feature/domain/entity/requested_resource_entity.dart';
import 'package:vision_app/features/user_features/request_resources_feature/domain/resources_repo.dart';

class GetRequestedResourcesUseCase {
  final ResourcesRepo repository;

  GetRequestedResourcesUseCase(this.repository);

  Future<Either<Failure, List<RequestedResourceEntity>>> call({
    String? departmentId,
  }) {
    return repository.getRequestedResources(departmentId: departmentId);
  }
}
