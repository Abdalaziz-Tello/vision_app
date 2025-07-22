import 'package:flutter/material.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/features/shared_features/auth/utils/validators.dart';
import 'package:vision_app/core/shared/widgets/custom_text_field.dart';

class AuthForm extends StatelessWidget {
  final bool isLogin;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final GlobalKey<FormState> formKey;

  const AuthForm({
    super.key,
    required this.isLogin,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          if (!isLogin) ...[
            CustomTextField(
              title: AppString.name,
              hintText: AppString.nameHint,
              controller: nameController,
              validator: AuthValidators.validateName,
            ),
            const SizedBox(height: 16),
          ],
          CustomTextField(
            title: AppString.email,
            hintText: AppString.enterEmail,
            controller: emailController,
            validator: AuthValidators.validateEmail,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            title: AppString.password,
            hintText: AppString.enterPassword,
            controller: passwordController,
            validator: (value) =>
                AuthValidators.validatePassword(value, isLogin: isLogin),
            isPassword: true,
          ),
        ],
      ),
    );
  }
}
