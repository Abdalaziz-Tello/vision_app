import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/exceptions.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/core/network/network_info.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/features/resources_feature/data/models/resource_request_model.dart';
import 'package:vision_app/features/resources_feature/data/remote_resources.dart';
import 'package:vision_app/features/resources_feature/domain/entity/academic_departments_entity.dart';
import 'package:vision_app/features/resources_feature/domain/entity/requested_resource_entity.dart';
import 'package:vision_app/features/resources_feature/domain/entity/resource_request_entity.dart';
import 'package:vision_app/features/resources_feature/domain/resources_repo.dart';

class ResourcesRepoImp implements ResourcesRepo {
  final RemoteResources remoteDataSource;
  final NetworkInfo networkInfo;

  ResourcesRepoImp({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<AcademicDepartmentsEntity>>>
  getAllAcademics() async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return Left(NoConnectionFailure(AppString.noInternet));
    }

    try {
      final result = await remoteDataSource.getAllAcademics();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<RequestedResourceEntity>>> getRequestedResources({
    String? departmentId,
  }) async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      return Left(NoConnectionFailure(AppString.noInternet));
    }

    try {
      final result = await remoteDataSource.getRequestedResources(
        departmentId: departmentId,
      );
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessage));
    }
  }

  //____________________________________________

  @override
  Future<Either<Failure, void>> submitResourceRequest(
    ResourceRequestEntity entity,
  ) async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      return Left(NoConnectionFailure(AppString.noInternet));
    }

    try {
      final model = ResourceRequestModel.fromEntity(entity);
      await remoteDataSource.submitResourceRequest(model);
      return const Right(null); // success, no data to return
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessage));
    }
  }

  //___________________________________________________________
  @override
  Future<Either<Failure, List<ResourceRequestEntity>>>
  getUsersResourcesRequest() {
    // TODO: implement getUsersResourcesRequest
    throw UnimplementedError();
  }
}
