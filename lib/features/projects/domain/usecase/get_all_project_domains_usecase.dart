import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/features/projects/domain/entities/project_domains_entity.dart';
import 'package:vision_app/features/projects/domain/repo/project_repository.dart';

class GetAllProjectDomainsUseCase {
  final ProjectRepository repository;

  GetAllProjectDomainsUseCase(this.repository);

  Future<Either<Failure, List<ProjectDomainsEntity>>> call() {
    return repository.getAllProjectDomains();
  }
}
