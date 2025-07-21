import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vision_app/core/di_storage_listner/build_context_extensions.dart';
import 'package:vision_app/core/res/app_images.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/res/keys/navigation_keys.dart';
import 'package:vision_app/core/widgets/custom_loading_indicator/custom_loading_indicator.dart';
import 'package:vision_app/features/auth/presentation/homePage_widgets/auth_dailog/auth_dialog_manager.dart';
import 'package:vision_app/features/auth/presentation/state_managments/current_user_bloc/current_user_bloc.dart';
import 'package:vision_app/core/widgets/custom_button.dart';
import 'package:vision_app/features/projects/presentation/state_managments/user_projects_bloc/user_projects_bloc.dart';

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

  //_____________________________________________________________
  Widget _buildUserAvatar(String firstLetter) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Builder(
        builder: (context) {
          return PopupMenuButton<int>(
            tooltip: AppString.account,
            color: AppColors.lightGrey,
            onSelected: (value) {
              if (value == 1) {
                // context.read<CurrentUserBloc>().add(LogoutRequested());
              } else if (value == 0) {
                final userState = context.read<CurrentUserBloc>().state;
                if (userState is CurrentUserLoaded) {
                  showProjectsPopup(context, userState.user.id);
                }
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 0, child: Text(' مشاريعي')),
              const PopupMenuDivider(),
              PopupMenuItem(value: 1, child: Text(AppString.logout)),
            ],
            child: CircleAvatar(
              backgroundColor: AppColors.navyBlue,
              child: Text(
                firstLetter,
                style: const TextStyle(color: AppColors.whiteColor),
              ),
            ),
          );
        },
      ),
    );
  }

  void showProjectsPopup(BuildContext context, String userId) {
    final screenWidth = context.screenWidth;
    final popupWidth = screenWidth.clamp(300.0, 400.0);

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: AppColors.blackColor.withOpacity(0.2),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.topRight,
          child: SafeArea(
            child: Material(
              color: AppColors.transparentColor,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(16),
                width: popupWidth,
                height: 200, //  height
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: AppColors.gray600, blurRadius: 12),
                  ],
                ),
                child: BlocProvider.value(
                  value: context.read<UserProjectsBloc>()
                    ..add(LoadUserProjects(userId)),
                  child: BlocBuilder<UserProjectsBloc, UserProjectsState>(
                    builder: (context, state) {
                      Widget content;

                      if (state is UserProjectsLoading) {
                        content = const Center(
                          // child: CircularProgressIndicator(
                          //   color: AppColors.navyBlue,
                          // ),
                          child: Center(child: CustomLoadingIndicator()),
                        );
                      } else if (state is UserProjectsError) {
                        content = Center(child: Text(' ${state.message}'));
                      } else if (state is UserProjectsLoaded) {
                        if (state.projects.isEmpty) {
                          content = Center(
                            child: Text(AppString.noProjectsForYouYet),
                          );
                        } else {
                          content = ListView.separated(
                            itemCount: state.projects.length,
                            separatorBuilder: (_, __) => const Divider(),
                            itemBuilder: (context, index) {
                              final project = state.projects[index];
                              return ListTile(
                                leading: const Icon(Icons.badge),
                                title: Text(
                                  project.title,
                                  textAlign: TextAlign.right,
                                ),
                                subtitle: Text(
                                  'من: ${project.projectOwnerName}',
                                  textAlign: TextAlign.right,
                                ),
                                onTap: () {
                                  context.pop();
                                  // Handle project selection here
                                  context.push(
                                    NavigationKeys.projectDetailsPageKey,
                                    extra: project.id,
                                  );
                                },
                              );
                            },
                          );
                        }
                      } else {
                        content = const SizedBox();
                      }

                      return SizedBox.expand(child: content);
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
