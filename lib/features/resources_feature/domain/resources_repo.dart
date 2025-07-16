import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/features/resources_feature/domain/entity/academic_departments_entity.dart';
import 'package:vision_app/features/resources_feature/domain/entity/requested_resource_entity.dart';
import 'package:vision_app/features/resources_feature/domain/entity/resource_request_entity.dart';

abstract class ResourcesRepo {
  Future<Either<Failure, List<AcademicDepartmentsEntity>>> getAllAcademics();
  Future<Either<Failure, List<RequestedResourceEntity>>> getRequestedResources({
    String? departmentId,
  });
  Future<Either<Failure, void>> submitResourceRequest(
    ResourceRequestEntity entity,
  );
  Future<Either<Failure, List<ResourceRequestEntity>>> getUsersResourcesRequest();
}
