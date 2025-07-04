import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/features/projects/domain/entities/create_project_entity.dart';
import 'package:vision_app/features/projects/domain/entities/project_domains_entity.dart';

abstract class ProjectRepository {
  Future<Either<Failure, List<ProjectDomainsEntity>>> getAllProjectDomains();
  Future<Either<Failure, String>> createProject(CreateProjectEntity entity);
}
