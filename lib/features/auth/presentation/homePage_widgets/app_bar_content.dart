import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_app/core/res/app_images.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/features/auth/presentation/homePage_widgets/auth_dailog/auth_dialog_manager.dart';
import 'package:vision_app/features/auth/presentation/state_managments/current_user_bloc/current_user_bloc.dart';
import 'package:vision_app/core/widgets/custom_button.dart';

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
                  switch (state) {
                    case CurrentUserLoaded():
                      final email = state.user.email;
                      final firstLetter = email.isNotEmpty
                          ? email[0].toUpperCase()
                          : '?';
                      return _buildUserAvatar(firstLetter);
                    default:
                      return isWide
                          ? _buildAuthButtons()
                          : _buildPopupMenu(context);
                  }
                },
              ),
              Image.asset(AppImages.logo, width: 120, fit: BoxFit.contain),
            ],
          ),
        );
      },
    );
  }

  static Widget _buildAuthButton({required bool isLogin}) {
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

  Widget _buildAuthButtons() {
    return Wrap(
      spacing: 12,
      children: [
        _buildAuthButton(isLogin: true),
        _buildAuthButton(isLogin: false),
      ],
    );
  }

  //_____________________________________________________________
  Widget _buildPopupMenu(context) {
    return PopupMenuButton<int>(
      color: AppColors.lightGrey,
      tooltip: AppString.account,
      icon: const Icon(Icons.manage_accounts, color: AppColors.navyBlue),
      onSelected: (value) {
        if (value == 0) {
          AuthDialogManager.show(context, isLogin: true);
        } else {
          AuthDialogManager.show(context, isLogin: false);
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: 0, child: Text(AppString.login)),
        PopupMenuItem(value: 1, child: Text(AppString.signup)),
      ],
    );
  }

  //__________________________________________________________
  Widget _buildUserAvatar(String firstLetter) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PopupMenuButton<int>(
        tooltip: AppString.logout,
        color: AppColors.lightGrey,
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 0,
            child: Text(AppString.logout),
            onTap: () {
              // context.read<CurrentUserBloc>().add(LogoutRequested());
            },
          ),
        ],
        child: CircleAvatar(
          backgroundColor: AppColors.navyBlue,
          child: Text(
            firstLetter,
            style: const TextStyle(color: AppColors.whiteColor),
          ),
        ),
      ),
    );
  }
}
