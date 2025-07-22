import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/domain/entities/upload_file_entity.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/domain/repo/project_repository.dart';

class UploadFileUseCase {
  final ProjectRepository repository;

  UploadFileUseCase(this.repository);

  Future<Either<Failure, UploadFileEntity>> call(PlatformFile file) {
    return repository.uploadFile(file);
  }
}
