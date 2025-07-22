import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/core/shared/entities/project_entities/project_entity.dart';
import 'package:vision_app/features/user_features/user_projects_features/get_projects_by_user_id/domain/get_projects_by_user_id_repo.dart';

class GetProjectsByUseridUsecase {
  final GetProjectsByUserIdRepo repository;

  GetProjectsByUseridUsecase(this.repository);

  Future<Either<Failure, List<ProjectEntity>>> call(String userId) {
    return repository.getProjectsByUserId(userId);
  }
}
