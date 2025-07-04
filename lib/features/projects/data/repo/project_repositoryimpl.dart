import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/exceptions.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/core/network/network_info.dart';
import 'package:vision_app/features/projects/data/datasource/project_remote_datasource.dart';
import 'package:vision_app/features/projects/data/models/create_project_model.dart';
import 'package:vision_app/features/projects/domain/entities/create_project_entity.dart';
import 'package:vision_app/features/projects/domain/entities/project_domains_entity.dart';
import 'package:vision_app/features/projects/domain/repo/project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProjectRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ProjectDomainsEntity>>>
  getAllProjectDomains() async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      return Left(NoConnectionFailure("No internet connection"));
    }

    try {
      final result = await remoteDataSource.getAllProjectDomains();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, String>> createProject(
    CreateProjectEntity entity,
  ) async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      return Left(NoConnectionFailure("No internet connection"));
    }

    try {
      final model = CreateProjectModel(
        title: entity.title,
        description: entity.description,
        coverImageUrl: entity.coverImageUrl,
        isUniversityStudent: entity.isUniversityStudent,
        projectDomainId: entity.projectDomainId,
        attachments: entity.attachments
            .map(
              (e) => ProjectAttachmentModel(
                fileUrl: e.fileUrl,
                fileName: e.fileName,
                fileType: e.fileType,
                fileSize: e.fileSize,
              ),
            )
            .toList(),
      );

      final projectId = await remoteDataSource.createProject(model);
      return Right(projectId);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    }
  }
}
