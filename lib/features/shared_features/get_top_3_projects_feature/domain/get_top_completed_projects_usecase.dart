import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/core/shared/entities/project_entities/project_entity.dart';
import 'package:vision_app/features/shared_features/get_top_3_projects_feature/domain/get_top_completed_projects_repo.dart';

class GetTopCompletedProjectsUseCase {
  final GetTopCompletedProjectsRepo repository;

  GetTopCompletedProjectsUseCase(this.repository);

  Future<Either<Failure, List<ProjectEntity>>> call() {
    return repository.getTopCompletedProjects();
  }
}
