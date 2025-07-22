import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/exceptions.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/core/network/network_info.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/shared/entities/project_entities/project_entity.dart';
import 'package:vision_app/features/shared_features/get_project_details_feature/data/remote_get_poject_details.dart';
import 'package:vision_app/features/shared_features/get_project_details_feature/domain/get_project_details_repository.dart';

class GetProjectDetailsRepoImp implements GetProjectDetailsRepository {
  final RemoteGetPojectDetails remoteDataSource;
  final NetworkInfo networkInfo;

  GetProjectDetailsRepoImp({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ProjectEntity>> getProjectById(
    String projectId,
  ) async {
    if (!await networkInfo.isConnected) {
      return Left(NoConnectionFailure(AppString.noInternet));
    }

    try {
      final model = await remoteDataSource.getProjectById(projectId);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    }
  }
}
