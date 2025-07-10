import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_app/core/res/app_images.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/features/auth/presentation/homePage_widgets/auth_dialog_manager.dart';
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
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<CurrentUserBloc, CurrentUserState>(
                builder: (context, state) {
                  if (state is CurrentUserLoaded) {
                    final email = state.user.email;
                    final firstLetter = email.isNotEmpty
                        ? email[0].toUpperCase()
                        : '?';

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PopupMenuButton<int>(
                        tooltip: 'logOut',
                        color: AppColors.lightGrey,
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 0,
                            child: const Text("تسجيل الخروج"),
                            onTap: () {
                              // context
                              //     .read<CurrentUserBloc>()
                              //     .add(LogoutRequested());
                            },
                          ),
                        ],
                        child: CircleAvatar(
                          backgroundColor: AppColors.navyBlue,
                          child: Text(
                            firstLetter,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return isWide
                        ? Wrap(
                            spacing: 12,
                            children: [
                              _buildAuthButton(isLogin: true),
                              _buildAuthButton(isLogin: false),
                            ],
                          )
                        : PopupMenuButton<int>(
                            color: AppColors.lightGrey,
                            tooltip: 'Account',
                            icon: const Icon(
                              Icons.manage_accounts,
                              color: AppColors.navyBlue,
                            ),
                            onSelected: (value) {
                              if (value == 0) {
                                AuthDialogManager.show(context, isLogin: true);
                              } else if (value == 1) {
                                AuthDialogManager.show(context, isLogin: false);
                              }
                            },
                            itemBuilder: (context) => const [
                              PopupMenuItem(
                                value: 0,
                                child: Text('تسجيل الدخول'),
                              ),
                              PopupMenuItem(
                                value: 1,
                                child: Text('إنشاء حساب'),
                              ),
                            ],
                          );
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
        bgColor: isLogin ? AppColors.lightBlue : Colors.white,
        textColor: isLogin ? Colors.white : AppColors.lightBlue,
        onTap: null,
      ),
    );
  }
}
