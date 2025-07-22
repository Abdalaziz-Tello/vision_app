import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vision_app/core/errors/error_model.dart';
import 'package:vision_app/core/res/keys/app_keys.dart';
import 'package:vision_app/features/shared_features/auth/data/auth_response_model.dart';
import '../../../../core/errors/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> signIn({
    required String email,
    required String password,
  });

  Future<AuthResponseModel> signUp({
    required String email,
    required String password,
    required String name,
  });

  Future<AuthResponseModel?> getCurrentUser();
}

//TODO : change the netwrok connection ...DONE✅
//! the normal way for auth :
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final GoTrueClient auth;

  AuthRemoteDataSourceImpl({required this.auth});
  //__________________________________________________________________________
  @override
  Future<AuthResponseModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      print('[AuthRemote] Initiating sign in for $email');

      final response = await auth.signInWithPassword(
        email: email,
        password: password,
      );

      print('[AuthRemote] Received auth response: ${response.user?.id}');

      if (response.user == null) {
        print('[AuthRemote] No user returned in response');
        throw ServerException(
          errorModel: ErrorModel(errorMessage: 'Authentication failed'),
        );
      }
      print(response);
      final model = AuthResponseModel.fromJson({
        'id': response.user!.id,
        'email': response.user!.email,
        'is_verified': response.user!.confirmedAt != null,
        'access_token': response.session?.accessToken,
        'refresh_token': response.session?.refreshToken,

        'user_metadata': response.user!.userMetadata ?? {},
      });

      print('[AuthRemote] Successfully created auth model: ${model.toJson()}');

      return model;
    } on AuthException catch (e) {
      print('[AuthRemote] Auth error: ${e.message}');
      throw ServerException(errorModel: ErrorModel(errorMessage: e.message));
    } catch (e, stack) {
      print('[AuthRemote] Unexpected error: $e\n$stack');
      throw ServerException(
        errorModel: ErrorModel(errorMessage: 'Authentication failed'),
      );
    }
  }

  //______________________________________________________________________________
  @override
  Future<AuthResponseModel> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      print('[AuthRemote] Initiating sign up for $email');

      final response = await auth.signUp(
        email: email,
        password: password,
        data: {
          'role': AppKeys.studentKey, //AppKeys.microboostAdminKey
          'name': name,
        },
      );

      print('[AuthRemote] Received sign up response: ${response.user?.id}');

      if (response.user == null) {
        print('[AuthRemote] No user returned in sign up response');
        throw ServerException(
          errorModel: ErrorModel(errorMessage: 'Sign up failed'),
        );
      }

      print('User email: ${response.user!.email}');
      print('Access token: ${response.session?.accessToken}');

      final model = AuthResponseModel.fromJson({
        'id': response.user!.id,
        'email': response.user!.email ?? '',
        'is_verified': response.user!.confirmedAt != null,
        'access_token': response.session?.accessToken ?? '',
        'refresh_token': response.session?.refreshToken ?? '',
        'user_metadata': response.user!.userMetadata ?? {},
      });

      //  print('[AuthRemote] Successfully created auth model: ${model.toJson()}');

      return model;
    } on AuthException catch (e) {
      print('[AuthRemote] Auth error on sign up: ${e.message}');
      throw ServerException(errorModel: ErrorModel(errorMessage: e.message));
    } catch (e, stack) {
      print('[AuthRemote] Unexpected error on sign up: $e\n$stack');
      throw ServerException(
        errorModel: ErrorModel(errorMessage: 'Sign up failed'),
      );
    }
  }

  //______________________________________________________________________
  @override
  Future<AuthResponseModel?> getCurrentUser() async {
    final user = auth.currentUser;

    if (user == null) {
      print('[Remote] No current user found.');
      return null;
    }
    print('user : $user');
    final session = auth.currentSession;

    print("CurrentUserBloc: Fetched user: ${user.email}");
    print('session: ${session?.accessToken}');

    return AuthResponseModel.fromJson({
      'id': user.id,
      'email': user.email ?? '',
      'is_verified': user.confirmedAt != null,
      'access_token': session?.accessToken,
      'refresh_token': session?.refreshToken,
      'user_metadata': user.userMetadata ?? {},
    });
  }
}
