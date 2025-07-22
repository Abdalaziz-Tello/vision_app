import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/core/shared/entities/resources_entity/resource_request_entity.dart';

abstract class GetUsersResourceRequestsRepo {
  Future<Either<Failure, List<ResourceRequestEntity>>>
  getUsersResourcesRequest();
}
