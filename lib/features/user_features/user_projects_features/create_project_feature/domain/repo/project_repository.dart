import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/domain/entities/create_project_entity.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/domain/entities/project_domains_entity.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/domain/entities/upload_file_entity.dart';

abstract class ProjectRepository {
  Future<Either<Failure, List<ProjectDomainsEntity>>> getAllProjectDomains();
  Future<Either<Failure, String>> createProject(CreateProjectEntity entity);
  Future<Either<Failure, UploadFileEntity>> uploadFile(PlatformFile file);
 // Future<Either<Failure, ProjectEntity>> getProjectById(String projectId);
 // Future<Either<Failure, List<ProjectEntity>>> getTopCompletedProjects();
 // Future<Either<Failure, List<ProjectEntity>>> getAllProjects();

  // Future<Either<Failure, List<ProjectEntity>>> getProjectsByUserId(
  //   String userId,
  // );
  //! shall i make it as saperated feature ?
  // Future<Either<Failure, void>> createInvitation(InvitationEntity entity);
}
