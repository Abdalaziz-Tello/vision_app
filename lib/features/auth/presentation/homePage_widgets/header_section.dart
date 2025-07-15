import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vision_app/core/di_storage_listner/build_context_extensions.dart';
import 'package:vision_app/core/res/app_images.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/res/keys/navigation_keys.dart';
import 'package:vision_app/core/widgets/custom_snack_bar_function.dart';
import 'package:vision_app/features/auth/presentation/homePage_widgets/animated_custom_button.dart';
import 'package:vision_app/features/auth/presentation/state_managments/current_user_bloc/current_user_bloc.dart';

//header image + button of the create projects
class HeaderSection extends StatelessWidget {
  final GlobalKey<AnimatedCustomButtonState> buttonKey;

  const HeaderSection({super.key, required this.buttonKey});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isSmallScreen = screenWidth < 800;

        return Stack(
          alignment: isSmallScreen ? Alignment.center : Alignment.bottomCenter,
          children: [
            Image.asset(
              AppImages.header,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding: isSmallScreen
                    ? EdgeInsets.only(top: context.screenHeight * 0.09)
                    : EdgeInsets.only(bottom: context.screenHeight * 0.07),
                child: AnimatedCustomButton(
                  width: screenWidth * 0.21,
                  height: screenWidth * 0.075,
                  fontSize: screenWidth * 0.02,
                  key: buttonKey,
                  text: AppString.showYourProjectNow,
                  bgColor: AppColors.brightBlue,
                  textColor: AppColors.navyBlue,
                  enableHoverEffect: true,
                  hoverScale: 1.1,
                  onTap: () {
                    final state = context.read<CurrentUserBloc>().state;
                    if (state is CurrentUserLoaded) {
                      context.push(NavigationKeys.createProjectPageKey);
                    } else {
                      buttonKey.currentState?.triggerShake();
                      ScaffoldMessenger.of(context).showSnackBar(
                        customSnackBar(
                          AppString.pleaseLoginToCreateProject,
                          AppColors.redColor,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
    ).animate().slideX(delay: 0.2.seconds, duration: 0.2.seconds, begin: -1);
  }
}
