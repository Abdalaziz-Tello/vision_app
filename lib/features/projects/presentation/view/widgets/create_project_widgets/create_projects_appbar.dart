import 'package:flutter/material.dart';
import 'package:vision_app/core/res/app_images.dart';
import 'package:vision_app/core/res/color/app_colors.dart';

class CreateProjectsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CreateProjectsAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.whiteColor,
      shadowColor: AppColors.whiteColor,
      scrolledUnderElevation: 0,
      elevation: 0,
      actions: [Image.asset(AppImages.logo, width: 120, fit: BoxFit.contain)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
