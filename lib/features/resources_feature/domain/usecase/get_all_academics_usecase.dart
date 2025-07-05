import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/features/resources_feature/domain/entity/academic_departments_entity.dart';
import 'package:vision_app/features/resources_feature/domain/resources_repo.dart';

class GetAllAcademicsUseCase {
  final ResourcesRepo repository;

  GetAllAcademicsUseCase(this.repository);

  Future<Either<Failure, List<AcademicDepartmentsEntity>>> call() {
    return repository.getAllAcademics();
  }
}
