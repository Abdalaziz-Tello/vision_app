// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/shared/widgets/custom_button.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget({
    super.key,
    required this.onTap,
    required this.failureText,
  });

  final void Function()? onTap;
  final String failureText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning_rounded,
              color: AppColors.navyBlue,
              size: 64,
              shadows: [Shadow(color: AppColors.blue50, blurRadius: 12)],
            ),

            const SizedBox(height: 16),

            Text(
              AppString.errorOccurred, // 'حدث خطأ!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.navyBlue,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              failureText,
              style: TextStyle(fontSize: 15, color: AppColors.gray800),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            CustomButton(
              text: AppString.tryAgain,
              onTap: onTap,
              bgColor: AppColors.navyBlue,
              textColor: AppColors.reallyWhite,
              fontSize: 15,
              width: 180,
              height: 45,
              borderRadius: 12,
              enableHoverEffect: true,
              hoverScale: 1.07,
            ),
          ],
        ),
      ),
    );
  }
}
