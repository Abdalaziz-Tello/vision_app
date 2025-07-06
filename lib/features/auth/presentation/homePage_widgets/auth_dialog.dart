// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:vision_app/core/res/app_string.dart';
// import 'package:vision_app/core/res/color/app_colors.dart';
// import 'package:vision_app/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:vision_app/features/view/widgets/create_project_widgets/custom_text_field.dart';

// class AuthDialog extends StatefulWidget {
//   final String title;
//   final BuildContext blocContext;
//   final void Function(BuildContext blocContext, String email, String password)
//   onSubmit;

//   const AuthDialog({
//     super.key,
//     required this.title,
//     required this.onSubmit,
//     required this.blocContext,
//   });

//   @override
//   State<AuthDialog> createState() => _AuthDialogState();
// }

// class _AuthDialogState extends State<AuthDialog> {
//   final _formKey = GlobalKey<FormState>();
//   late final TextEditingController _emailController;
//   late final TextEditingController _passwordController;

//   @override
//   void initState() {
//     super.initState();
//     _emailController = TextEditingController();
//     _passwordController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _submit() {
//     if (_formKey.currentState!.validate()) {
//       widget.onSubmit(
//         widget.blocContext,
//         _emailController.text.trim(),
//         _passwordController.text.trim(),
//       );
//     }
//   }

//   String? _validateEmail(String? value) {
//     if (value == null || value.isEmpty) return AppString.emailRequired;
//     if (!value.contains('@')) return AppString.emailInvalid;
//     return null;
//   }

//   String? _validatePassword(String? value) {
//     if (value == null || value.isEmpty) return AppString.passwordRequired;
//     if (value.length < 6) return AppString.passwordTooShort;
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: AppColors.reallyWhite,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(widget.title, style: const TextStyle(fontSize: 25)),
//           IconButton(
//             icon: const Icon(Icons.close),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//         ],
//       ),
//       content: BlocListener<AuthBloc, AuthState>(
//         listener: (context, state) {
//           if (state is AuthSuccess) {
//             context.pop();
//           } else if (state is AuthFailure) {
//             ScaffoldMessenger.of(
//               context,
//             ).showSnackBar(SnackBar(content: Text(state.message)));
//           }
//         },
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 CustomTextField(
//                   title: AppString.email,
//                   hintText: AppString.enterEmail,
//                   controller: _emailController,
//                   validator: _validateEmail,
//                 ),
//                 CustomTextField(
//                   title: AppString.password,
//                   hintText: AppString.enterPassword,
//                   controller: _passwordController,
//                   validator: _validatePassword,
//                 ),
//                 const SizedBox(height: 20),
//                 BlocBuilder<AuthBloc, AuthState>(
//                   builder: (context, state) {
//                     if (state is AuthLoading) {
//                       return CircularProgressIndicator(
//                         color: AppColors.lightBlue,
//                       );
//                     }
//                     return ElevatedButton(
//                       onPressed: _submit,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.lightBlue,
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 30,
//                           vertical: 12,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: Text(
//                         widget.title,
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// features/auth/presentation/widgets/auth_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          widget.onSuccess();
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: AlertDialog(
        backgroundColor: AppColors.reallyWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.isLogin ? AppString.login : AppString.signup,
              style: const TextStyle(fontSize: 25),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!widget.isLogin)
                  CustomTextField(
                    title: AppString.name,
                    hintText: 'جميل جمال',
                    controller: _nameController,
                    validator: _validateName,
                    //  obscureText: true,
                  ),
                CustomTextField(
                  title: AppString.email,
                  hintText: AppString.enterEmail,
                  controller: _emailController,
                  validator: _validateEmail,
                ),
                CustomTextField(
                  title: AppString.password,
                  hintText: AppString.enterPassword,
                  controller: _passwordController,
                  validator: _validatePassword,
                  //  obscureText: true,
                ),
                const SizedBox(height: 20),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const CircularProgressIndicator(
                        color: AppColors.lightBlue,
                      );
                    }
                    return ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.lightBlue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        widget.isLogin ? AppString.login : AppString.signup,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return AppString.emailRequired;
    if (!value.contains('@')) return AppString.emailInvalid;
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return AppString.passwordRequired;
    if (value.length < 6) return AppString.passwordTooShort;
    return null;
  }

  String? _validateName(String? name) {
    if (name == null || name.isEmpty) return AppString.nameRequired;
    return null;
  }
}
