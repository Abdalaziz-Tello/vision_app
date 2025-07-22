import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/features/shared_features/auth/domain/auth_response.dart';

abstract class AuthRepository {
 //singIN :
  Future<Either<Failure, AuthEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
 //signUP :
  Future<Either<Failure, AuthEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });
//to check the userstate :
 Future<Either<Failure, AuthEntity?>> getCurrentUser();

}
