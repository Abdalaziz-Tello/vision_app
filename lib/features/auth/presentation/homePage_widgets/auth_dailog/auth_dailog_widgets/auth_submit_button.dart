import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/widgets/custom_button.dart';
import 'package:vision_app/features/auth/presentation/state_managments/auth_bloc/auth_bloc.dart';

class AuthSubmitButton extends StatelessWidget {
  final bool isLogin;
  final VoidCallback onSubmit;

  const AuthSubmitButton({
    super.key,
    required this.isLogin,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const SizedBox(
            height: 48,
            child: Center(
              child: CircularProgressIndicator(color: AppColors.lightBlue),
            ),
          );
        }

        return CustomButton(
          text: isLogin ? AppString.login : AppString.signup,
          onTap: onSubmit,
          bgColor: AppColors.lightBlue,
          textColor: Colors.white,
          width: double.infinity,
          height: 48,
          fontSize: 16,
          borderRadius: 12,
        );
      },
    );
  }
}
