import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/features/shared_features/auth/presentation/state_managments/current_user_bloc/current_user_bloc.dart';
import 'package:vision_app/features/user_features/user_projects_features/get_projects_by_user_id/presentation/view/user_projects_popup.dart';

class LoggedInAvatar extends StatelessWidget {
  final String email;
  const LoggedInAvatar({required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    final firstLetter = email.isNotEmpty ? email[0].toUpperCase() : '?';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PopupMenuButton<int>(
        tooltip: AppString.account,
        color: AppColors.lightGrey,
        onSelected: (value) {
          final userState = context.read<CurrentUserBloc>().state;
          if (value == 0 && userState is CurrentUserLoaded) {
            showProjectsPopup(context, userState.user.id);
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 0,
            child: Row(
              children: [
                Icon(Icons.card_travel, color: AppColors.navyBlue, size: 22),
                SizedBox(width: 5),
                Text(AppString.myProjects, style: _buildTextStyle()),
              ],
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem(
            value: 1,
            child: Row(
              children: [
                Icon(
                  Icons.notifications_outlined,
                  color: AppColors.navyBlue,
                  size: 22,
                ),
                SizedBox(width: 5),
                Text(AppString.alerts, style: _buildTextStyle()),
              ],
            ),
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

  TextStyle _buildTextStyle() {
    return TextStyle(color: AppColors.navyBlue, fontWeight: FontWeight.w600);
  }
}
