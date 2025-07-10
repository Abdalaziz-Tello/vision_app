import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vision_app/core/di_storage_listner/build_context_extensions.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/widgets/custom_button.dart';
import 'package:vision_app/core/widgets/custom_snack_bar_function.dart';
import 'package:vision_app/features/auth/presentation/homePage_widgets/verification_dialog.dart';
import 'package:vision_app/features/auth/presentation/state_managments/auth_bloc/auth_bloc.dart';
import 'package:vision_app/features/projects/presentation/view/widgets/create_project_widgets/custom_text_field.dart';

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

  //responsive width calculation
  double _getDialogWidth(BuildContext context) {
    final screenWidth = context.screenWidth;

    // breakpoints
    if (screenWidth <= 600) {
      return screenWidth * 0.95; // Mobile: 95% width
    } else if (screenWidth <= 1024) {
      return screenWidth * 0.7; // Tablet: 70% width
    } else if (screenWidth <= 1440) {
      return screenWidth * 0.5; // Desktop: 50% width
    } else {
      return screenWidth * 0.5; // Large desktop: 35% width
    }
  }

  // padding
  EdgeInsets _getDialogPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= 600) {
      return const EdgeInsets.all(16); // Mobile: smaller padding
    } else {
      return const EdgeInsets.all(24); // Tablet/Desktop: larger padding
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          widget.onSuccess(); //context.pop() //Close dialog
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              widget.isLogin ? 'log in correctly' : 'signUp correctly',
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
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(state.message, AppColors.redColor),
            // SnackBar(
            //   content: Text(state.message),
            //   backgroundColor: AppColors.redColor,
            //   behavior: SnackBarBehavior.floating,
            // ),
          );
        }
      },
      child: Dialog(
        backgroundColor: AppColors.reallyWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final dialogWidth = _getDialogWidth(context);
            final dialogPadding = _getDialogPadding(context);

            return ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: dialogWidth,
                minWidth: 280,
                maxHeight:
                    MediaQuery.of(context).size.height *
                    0.9, // Increased max height
              ),
              child: Container(
                padding: dialogPadding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header with close button
                    _buildHeader(context),

                    // Form content - wrapped in Flexible to allow scrolling
                    Flexible(
                      child: SingleChildScrollView(child: _buildFormContent()),
                    ),

                    // Submit button - always visible at bottom
                    const SizedBox(height: 20),
                    _buildSubmitButton(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.isLogin ? AppString.login : AppString.signup,
            style:
                Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ) ??
                const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
          tooltip: 'Close',
        ),
      ],
    );
  }

  Widget _buildFormContent() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),

          // Name field for signup
          if (!widget.isLogin) ...[
            CustomTextField(
              title: AppString.name,
              hintText: AppString.nameHint,
              controller: _nameController,
              validator: _validateName,
            ),
            const SizedBox(height: 16),
          ],

          // Email field
          CustomTextField(
            title: AppString.email,
            hintText: AppString.enterEmail,
            controller: _emailController,
            validator: _validateEmail,
          ),
          const SizedBox(height: 16),

          // Password field
          CustomTextField(
            title: AppString.password,
            hintText: AppString.enterPassword,
            controller: _passwordController,
            validator: _validatePassword,
            isPassword: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const SizedBox(
            height: 48,
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.lightBlue,
                strokeWidth: 2,
              ),
            ),
          );
        }

        return CustomButton(
          text: widget.isLogin ? AppString.login : AppString.signup,
          onTap: _submit,
          bgColor: AppColors.lightBlue,
          textColor: Colors.white,
          width: double.infinity,
          height: 48,
          fontSize: 16,
          borderRadius: 12,
          margin: EdgeInsets.zero,
        );
      },
    );
  }

  //validators :
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return AppString.emailRequired;

    // More comprehensive email validation
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) return AppString.emailInvalid;

    return null;
  }

  String? _validateName(String? name) {
    if (name == null || name.isEmpty) return AppString.nameRequired;

    //name validation
    if (name.trim().length < 2) return 'Name must be at least 2 characters';

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return AppString.passwordRequired;

    // For login, basic validation is enough
    if (widget.isLogin) return null;

    //password validation for signup
    if (value.length < 8) return AppString.passwordTooShort;

    final hasUpper = value.contains(RegExp(r'[A-Z]'));
    final hasLower = value.contains(RegExp(r'[a-z]'));
    final hasDigit = value.contains(RegExp(r'[0-9]'));
    final hasSpecial = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    if (!hasUpper) return AppString.passwordUpper;
    if (!hasLower) return AppString.passwordLower;
    if (!hasDigit) return AppString.passwordNumber;
    if (!hasSpecial) return AppString.passwordSpecial;

    return null;
  }
}
