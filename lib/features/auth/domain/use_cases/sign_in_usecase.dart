import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/features/auth/domain/auth_repository.dart';
import 'package:vision_app/features/auth/domain/auth_response.dart';

class SignInWithEmailAndPassword {
  final AuthRepository repository;

  SignInWithEmailAndPassword(this.repository);
  Future<Either<Failure, AuthEntity>> call({
    required String email,
    required String password,
  }) async {
    //!make sure from the returend type
    //TODO : add DartZ!!✅DONE

    return await repository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
