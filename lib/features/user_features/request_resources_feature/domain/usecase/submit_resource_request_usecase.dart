import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/core/shared/entities/resources_entity/resource_request_entity.dart';
import 'package:vision_app/features/user_features/request_resources_feature/domain/resources_repo.dart';

class SubmitResourceRequestUseCase {
  final ResourcesRepo repository;

  SubmitResourceRequestUseCase(this.repository);

  Future<Either<Failure, void>> call(ResourceRequestEntity entity) {
    return repository.submitResourceRequest(entity);
  }
}
