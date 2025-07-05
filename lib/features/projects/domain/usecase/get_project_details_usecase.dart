import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/features/projects/domain/entities/project_entity.dart';
import 'package:vision_app/features/projects/domain/repo/project_repository.dart';

class GetProjectDetailsUseCase {
  final ProjectRepository repo;

  GetProjectDetailsUseCase(this.repo);

  Future<Either<Failure, ProjectEntity>> call(String id) =>
      repo.getProjectById(id);
}
