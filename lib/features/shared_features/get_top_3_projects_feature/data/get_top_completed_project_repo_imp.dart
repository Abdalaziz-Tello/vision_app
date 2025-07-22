// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/exceptions.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/core/network/network_info.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/shared/entities/project_entities/project_entity.dart';
import 'package:vision_app/features/shared_features/get_top_3_projects_feature/data/top_completed_project_datasource.dart';
import 'package:vision_app/features/shared_features/get_top_3_projects_feature/domain/get_top_completed_projects_repo.dart';

class GetTopCompletedProjectsRepoImp implements GetTopCompletedProjectsRepo {
  final TopCompletedProjectDatasource remoteDataSource;
  final NetworkInfo networkInfo;
  GetTopCompletedProjectsRepoImp({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ProjectEntity>>> getTopCompletedProjects() async {
    if (!await networkInfo.isConnected) {
      return Left(NoConnectionFailure(AppString.noInternet));
    }

    try {
      final models = await remoteDataSource.getTopCompletedProjects();
      final entities = models.map((e) => e.toEntity()).toList();
      return Right(entities);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    }
  }
}
