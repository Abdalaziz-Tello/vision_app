import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/features/auth/domain/auth_response.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, AuthEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });
}
