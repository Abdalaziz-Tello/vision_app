import 'package:flutter/material.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/features/shared_features/auth/presentation/homePage_widgets/auth_dailog/auth_dialog_manager.dart';

class GuestPopupMenu extends StatelessWidget {
  const GuestPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      color: AppColors.lightGrey,
      tooltip: AppString.account,
      icon: const Icon(Icons.manage_accounts, color: AppColors.navyBlue),
      onSelected: (value) {
        AuthDialogManager.show(context, isLogin: value == 0);
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: 0, child: Text(AppString.login)),
        PopupMenuItem(value: 1, child: Text(AppString.signup)),
      ],
    );
  }
}
