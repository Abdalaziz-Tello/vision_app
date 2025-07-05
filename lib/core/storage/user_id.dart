import 'package:supabase_flutter/supabase_flutter.dart';

class UserSession {
  final GoTrueClient _auth;

  UserSession(this._auth);

  String? getCurrentUserId() {
    return _auth.currentUser?.id;
  }
}
