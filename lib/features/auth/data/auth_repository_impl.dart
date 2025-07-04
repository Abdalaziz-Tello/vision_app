import 'package:dartz/dartz.dart';
import 'package:vision_app/core/network/network_info.dart';
import 'package:vision_app/features/auth/data/auth_datasource.dart';
import 'package:vision_app/features/auth/domain/auth_repository.dart';
import 'package:vision_app/features/auth/domain/auth_response.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, AuthEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final isConnected = await networkInfo.isConnected;
    print('connected in signin:${isConnected}');
    if (!isConnected) {
      return Left(
        NoConnectionFailure("No internet connection"),
      ); //TODO : remove the message form here
    }

    try {
      final response = await remoteDataSource.signIn(
        email: email,
        password: password,
      );
      print('right in the repo of the signin ');

      return Right(response.toEntity());
    } on ServerException catch (e) {
      print('left in the repo of the signin:${e} ');
      return Left(ServerFailure(e.errorMessage));
    }
  }

  //_________________________________________________________________________
  @override
  Future<Either<Failure, AuthEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return Left(NoConnectionFailure("No internet connection"));
    }

    try {
      final response = await remoteDataSource.signUp(
        email: email,
        password: password,
      );
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessage));
    }
  }

  //____________________________________________________________
  //? shall i check the netwrok here ?!
  @override
  Future<Either<Failure, AuthEntity?>> getCurrentUser() async {
    try {
      final model = await remoteDataSource.getCurrentUser();
      if (model == null) return Right(null);

      return Right(model.toEntity());
    } catch (e) {
      return Left(ServerFailure("فشل التحقق من المستخدم الحالي"));
    }
  }
}
