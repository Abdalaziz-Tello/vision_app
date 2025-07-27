import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/features/microbots_features/features/tools_feature/domain/tools_entity.dart';

abstract class ToolsRepository {
  Future<Either<Failure, List<ToolsEntity>>> getAllTools();
}
