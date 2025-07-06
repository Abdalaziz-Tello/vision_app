import 'package:supabase_flutter/supabase_flutter.dart';

class UserSession {
  final GoTrueClient _auth;

  UserSession(this._auth);

  String? getCurrentUserId() {
    return _auth.currentUser?.id;
  }
}


/*
  supabase.auth.onAuthStateChange.listen((data) {
    final session = data.session;
    if (session != null) {
      // User logged in
      // Navigate to home or dashboard
    } else {
      // User logged out
      // Navigate to login page
    }
  });
*/