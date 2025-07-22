import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/domain/entities/project_domains_entity.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/domain/repo/project_repository.dart';

class GetAllProjectDomainsUseCase {
  final ProjectRepository repository;

  GetAllProjectDomainsUseCase(this.repository);

  Future<Either<Failure, List<ProjectDomainsEntity>>> call() {
    return repository.getAllProjectDomains();
  }
}
