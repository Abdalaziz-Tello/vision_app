import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/features/projects/domain/entities/create_project_entity.dart';
import 'package:vision_app/features/projects/domain/repo/project_repository.dart';

class CreateProjectUseCase {
  final ProjectRepository repository;

  CreateProjectUseCase(this.repository);

  Future<Either<Failure, String>> call(CreateProjectEntity entity) {
    return repository.createProject(entity);
  }
}
