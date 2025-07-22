
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vision_app/features/shared_features/auth/presentation/state_managments/current_user_bloc/current_user_bloc.dart';

// void startAuthStateListener(BuildContext context) {
//   Supabase.instance.client.auth.onAuthStateChange.listen((event) {
//     final session = event.session;

//     if (session != null) {
//       print('[AuthListener] User signed in');

//      context.read<CurrentUserBloc>().add(LoadCurrentUser());

//     } else {
//       print('[AuthListener] User signed out');
//     //  context.read<CurrentUserBloc>().add(LogoutRequested());
//     }
//   });
// }




//? is this the correct way to do it ?