import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/core/shared/entities/project_entities/project_entity.dart';

abstract class GetTopCompletedProjectsRepo {
  Future<Either<Failure, List<ProjectEntity>>> getTopCompletedProjects();
}
