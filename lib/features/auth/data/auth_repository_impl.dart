import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vision_app/features/auth/domain/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient supabaseClient;

  AuthRepositoryImpl({required this.supabaseClient});

  @override
  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final response = await supabaseClient.rpc(
      'signin',
      params: {'email': email, 'password': password},
    );

    if (response.error != null) {
      throw Exception(response.error!.message); //!TODO : change the exeptions
    }
    print('respons of the sign in:${response.data}');
    return response.data
        as String; //!(TODO ): the API return ?token or user ID ?
  }

  @override
  Future<void> signOut() async {
    await supabaseClient.auth.signOut();
  }
}
