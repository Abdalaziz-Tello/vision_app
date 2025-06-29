abstract class AuthRepository {
  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}