import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/core/shared/entities/project_entities/project_entity.dart';
import 'package:vision_app/features/microbots_features/get_all_projects_feature/domain/get_all_projects_repo.dart';

class GetAllProjectsUsecase {
  final GetAllProjectsRepo repository;

  GetAllProjectsUsecase(this.repository);

  Future<Either<Failure, List<ProjectEntity>>> call() {
    return repository.getAllProjects();
  }
}
