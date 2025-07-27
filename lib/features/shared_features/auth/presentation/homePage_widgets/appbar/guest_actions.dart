import 'package:flutter/material.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/shared/widgets/custom_button.dart';
import 'package:vision_app/features/shared_features/auth/presentation/homePage_widgets/auth_dailog/auth_dialog_manager.dart';

class GuestActions extends StatelessWidget {
  const GuestActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      children: const [AuthButton(isLogin: true), AuthButton(isLogin: false)],
    );
  }
}

//____________________________________________________________________
class AuthButton extends StatelessWidget {
  final bool isLogin;
  const AuthButton({required this.isLogin, super.key});

  @override
  Widget build(BuildContext context) {
    return AuthDialogManager(
      isLogin: isLogin,
      child: CustomButton(
        text: isLogin ? AppString.login : AppString.signup,
        bgColor: isLogin ? AppColors.lightBlue : AppColors.whiteColor,
        textColor: isLogin ? AppColors.whiteColor : AppColors.lightBlue,
        onTap: null,
      ),
    );
  }
}
