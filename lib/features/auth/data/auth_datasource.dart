import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vision_app/core/errors/error_model.dart';
import 'package:vision_app/features/auth/data/auth_response_model.dart';
import '../../../core/errors/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> signIn({
    required String email,
    required String password,
  });
}

//TODO : change the netwrok connection ...DONE✅
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthResponseModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await client
          .rpc('signin', params: {'email': email, 'password': password})
          .select()
          .single();

      // Check if null
      if (result == null || result.isEmpty) {
        throw ServerException(
          errorModel: ErrorModel(
            errorMessage: "No data returned from Supabase.",
          ),
        );
      }

      return AuthResponseModel.fromJson(result);
    } catch (error) {
      throw ServerException(
        errorModel: ErrorModel(errorMessage: error.toString()),
      );
    }
  }
}
