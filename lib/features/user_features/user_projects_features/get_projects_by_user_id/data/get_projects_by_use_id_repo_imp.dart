// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/exceptions.dart';

import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/core/network/network_info.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/shared/entities/project_entities/project_entity.dart';
import 'package:vision_app/features/user_features/user_projects_features/get_projects_by_user_id/data/remote_get_projects_by_use_id_datasource.dart';
import 'package:vision_app/features/user_features/user_projects_features/get_projects_by_user_id/domain/get_projects_by_user_id_repo.dart';

class GetProjectsByUseIdRepoImp implements GetProjectsByUserIdRepo {
  final RemoteGetProjectsByUseIdDatasource remoteDataSource;
  final NetworkInfo networkInfo;
  GetProjectsByUseIdRepoImp({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ProjectEntity>>> getProjectsByUserId(
    String userId,
  ) async {
    if (!await networkInfo.isConnected) {
      return Left(NoConnectionFailure(AppString.noInternet));
    }
    try {
      final models = await remoteDataSource.getProjectsByUserId(userId);
      final entities = models.map((e) => e.toEntity()).toList();
      return Right(entities);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    }
  }
}
