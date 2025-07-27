import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/features/microbots_features/features/tools_feature/domain/tools_entity.dart';
import 'package:vision_app/features/microbots_features/features/tools_feature/domain/tools_repo.dart';

class GetAllToolsUsecase {
  final ToolsRepository repository;

  GetAllToolsUsecase(this.repository);

  Future<Either<Failure, List<ToolsEntity>>> call() {
    return repository.getAllTools();
  }
}
