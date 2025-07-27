import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_app/core/res/app_images.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/features/shared_features/auth/presentation/homePage_widgets/appbar/guest_actions.dart';
import 'package:vision_app/features/shared_features/auth/presentation/homePage_widgets/appbar/guest_popup_menu.dart';
import 'package:vision_app/features/shared_features/auth/presentation/homePage_widgets/appbar/logged_in_avatar.dart';
import 'package:vision_app/features/shared_features/auth/presentation/state_managments/current_user_bloc/current_user_bloc.dart';

class AppBarContent extends StatelessWidget {
  const AppBarContent({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;

        return AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.whiteColor,
          shadowColor: AppColors.whiteColor,
          scrolledUnderElevation: 0,
          elevation: 0,
          flexibleSpace: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<CurrentUserBloc, CurrentUserState>(
                builder: (context, state) {
                  return switch (state) {
                    CurrentUserLoaded(:final user) => LoggedInAvatar(
                      email: user.email,
                    ),
                    _ => isWide ? const GuestActions() : const GuestPopupMenu(),
                  };
                },
              ),
              Image.asset(AppImages.logo, width: 120, fit: BoxFit.contain),
            ],
          ),
        );
      },
    );
  }
}


//

//

