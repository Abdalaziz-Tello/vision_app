import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vision_app/core/di_storage_listner/di.dart';
import 'package:vision_app/features/auth/presentation/state_managments/auth_bloc/auth_bloc.dart';
import 'auth_dialog.dart';

//*benifit of using it : Don't Repeat Yourself (DRY).
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
      //  behavior: HitTestBehavior.opaque,
      onTap: () => show(context, isLogin: isLogin),
      child: child,
    );
  }

  /// Static method to show the auth dialog manually
  static void show(BuildContext context, {required bool isLogin}) {
    showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (_) => sl<AuthBloc>(),
        child: AuthDialog(isLogin: isLogin, onSuccess: () => context.pop()),
      ),
    );
  }
}
