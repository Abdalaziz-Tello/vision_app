import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_app/core/di_storage_listner/build_context_extensions.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/shared/widgets/custom_snack_bar_function.dart';
import 'package:vision_app/features/shared_features/auth/presentation/homePage_widgets/auth_dailog/auth_dailog_widgets/auth_form.dart';
import 'package:vision_app/features/shared_features/auth/presentation/homePage_widgets/auth_dailog/auth_dailog_widgets/auth_submit_button.dart';
import 'package:vision_app/features/shared_features/auth/presentation/homePage_widgets/auth_dailog/auth_dailog_widgets/auth_dialog_header.dart';
import 'package:vision_app/features/shared_features/auth/presentation/homePage_widgets/verification_dialog.dart';
import 'package:vision_app/features/shared_features/auth/presentation/state_managments/auth_bloc/auth_bloc.dart';
import 'package:vision_app/features/shared_features/auth/utils/responsive_helper.dart';

//TODO : shall we make the responsive in another way

class AuthDialog extends StatefulWidget {
  final bool isLogin;
  final VoidCallback onSuccess;

  const AuthDialog({super.key, required this.isLogin, required this.onSuccess});

  @override
  State<AuthDialog> createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final name = _nameController.text.trim();

      if (widget.isLogin) {
        context.read<AuthBloc>().add(
          SignInRequested(email: email, password: password),
        );
      } else {
        context.read<AuthBloc>().add(
          SignUpRequested(email: email, password: password, name: name),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;

    return BlocListener<AuthBloc, AuthState>(
      listener: _handleAuthState,
      child: Dialog(
        backgroundColor: AppColors.reallyWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                // maxWidth: ResponsiveHelper.getDialogWidth(screenWidth),
                // minWidth:
                //     screenWidth *
                //     0.8.clamp(280, double.infinity), //  minWidth: 280,
                // maxHeight: context.screenHeight * 0.9,
                minWidth: 280.0,
                maxWidth: (screenWidth * 0.8).clamp(280.0, double.infinity),
                maxHeight: context.screenHeight * 0.9,
              ),
              child: Padding(
                padding: ResponsiveHelper.getDialogPadding(screenWidth),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AuthDialogHeader(
                      title: widget.isLogin
                          ? AppString.login
                          : AppString.signup,
                    ),
                    const SizedBox(height: 8),
                    Flexible(
                      child: SingleChildScrollView(
                        child: AuthForm(
                          isLogin: widget.isLogin,
                          emailController: _emailController,
                          passwordController: _passwordController,
                          nameController: _nameController,
                          formKey: _formKey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AuthSubmitButton(
                      isLogin: widget.isLogin,
                      onSubmit: _submit,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  //_________________________________________________________________

  void _handleAuthState(BuildContext context, AuthState state) {
    if (state is AuthSuccess) {
      widget.onSuccess();
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          widget.isLogin ? AppString.loginSuccess : AppString.signupSuccess,
          AppColors.green,
        ),
      );

      if (!widget.isLogin) {
        showDialog(
          context: context,
          builder: (context) => VerificationDialog(),
        );
      }
    } else if (state is AuthFailure) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnackBar(state.message, AppColors.redColor));
    }
  }
}
