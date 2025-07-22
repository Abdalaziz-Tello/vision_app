import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/core/shared/entities/project_entities/project_entity.dart';
import 'package:vision_app/features/shared_features/get_project_details_feature/domain/get_project_details_repository.dart';

class GetProjectDetailsUseCase {
  final GetProjectDetailsRepository repo;

  GetProjectDetailsUseCase(this.repo);

  Future<Either<Failure, ProjectEntity>> call(String id) =>
      repo.getProjectById(id);
}
