import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vision_app/core/res/app_string.dart';

class AuthDialogHeader extends StatelessWidget {
  const AuthDialogHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            //   widget.isLogin ? AppString.login : AppString.signup,
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
          tooltip: AppString.close,
        ),
      ],
    );
  }
}
