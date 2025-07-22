// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/exceptions.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/core/network/network_info.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/shared/entities/project_entities/project_entity.dart';
import 'package:vision_app/features/microbots_features/get_all_projects_feature/data/get_all_projects_remote_datasource.dart';
import 'package:vision_app/features/microbots_features/get_all_projects_feature/domain/get_all_projects_repo.dart';

class GetAllProjectsRepoImp implements GetAllProjectsRepo {
  final GetAllProjectsRemoteDatasource remoteDataSource;
  final NetworkInfo networkInfo;
  GetAllProjectsRepoImp({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ProjectEntity>>> getAllProjects() async {
    if (!await networkInfo.isConnected) {
      return Left(NoConnectionFailure(AppString.noInternet));
    }
    try {
      final models = await remoteDataSource.getProjects();
      final entities = models.map((e) => e.toEntity()).toList();
      return Right(entities);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    }
  }
}
