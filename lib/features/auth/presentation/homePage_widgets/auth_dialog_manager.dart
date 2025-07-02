// features/auth/presentation/widgets/auth_dialog_manager.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vision_app/features/auth/injection.dart';
import 'package:vision_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'auth_dialog.dart';

class AuthDialogManager extends StatelessWidget {
  final bool isLogin;
  final Widget child;

  const AuthDialogManager({
    super.key,
    required this.isLogin,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _showAuthDialog(context, isLogin),
      child: child,
    );
  }

  void _showAuthDialog(BuildContext context, bool isLogin) {
    showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (_) => AuthBloc(
          signInWithEmailAndPassword: sl(),
          signUpWithEmailAndPassword: sl(),
        ),
        child: AuthDialog(isLogin: isLogin, onSuccess: () => context.pop()),
      ),
    );
  }
}
