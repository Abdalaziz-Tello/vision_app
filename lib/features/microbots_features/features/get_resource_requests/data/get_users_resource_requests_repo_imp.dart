// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/exceptions.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/core/network/network_info.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/shared/entities/resources_entity/resource_request_entity.dart';
import 'package:vision_app/features/microbots_features/features/get_resource_requests/data/remote_get_users_resource_datasource.dart';
import 'package:vision_app/features/microbots_features/features/get_resource_requests/domain/get_users_resource_requests_repo.dart';

class GetUsersResourceRequestsRepoImp implements GetUsersResourceRequestsRepo {
  final RemoteGetUsersResourceDatasource remoteDataSource;
  final NetworkInfo networkInfo;
  GetUsersResourceRequestsRepoImp({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ResourceRequestEntity>>>
  getUsersResourcesRequest() async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      return Left(NoConnectionFailure(AppString.noInternet));
    }

    try {
      final result = await remoteDataSource.getUsersResourcesRequest();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessage));
    }
  }
}
