import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/features/projects/domain/entities/project_entity.dart';
import 'package:vision_app/features/projects/domain/repo/project_repository.dart';

class GetTopCompletedProjectsUseCase {
  final ProjectRepository repository;

  GetTopCompletedProjectsUseCase(this.repository);

  Future<Either<Failure, List<ProjectEntity>>> call() {
    return repository.getTopCompletedProjects();
  }
}
