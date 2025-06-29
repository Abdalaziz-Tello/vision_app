import 'package:vision_app/features/auth/domain/auth_repository.dart';

class SignInWithEmailAndPassword {
  final AuthRepository repository;

  SignInWithEmailAndPassword(this.repository);

  Future<String> call({required String email, required String password}) async {
    //!make sure from the returend type,
  //TODO : add DartZ!!
    return await repository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
