import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/exceptions.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/core/network/network_info.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/features/tools_feature/data/remote_tools.dart';
import 'package:vision_app/features/tools_feature/domain/tools_entity.dart';
import 'package:vision_app/features/tools_feature/domain/tools_repo.dart';

class ToolsRepositoryImpl implements ToolsRepository {
  final ToolsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ToolsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ToolsEntity>>> getAllTools() async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      return Left(NoConnectionFailure(AppString.noInternet));
    }

    try {
      final result = await remoteDataSource.getAllTools();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessage));
    }
  }
}
