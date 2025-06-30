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
  Future<Either<Failure, AuthResponse>> signInWithEmailAndPassword({
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
      return Right(response);
    } on ServerException catch (e) {
      print('left in the repo of the signin:${e} ');
      return Left(ServerFailure(e.errorMessage));
    }
  }
}
