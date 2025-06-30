import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/features/auth/domain/auth_response.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}
