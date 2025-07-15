// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/widgets/custom_button.dart';

class ProjectDetailsFailureWidget extends StatelessWidget {
  const ProjectDetailsFailureWidget({
    super.key,
    required this.onTap,
    required this.failureText,
  });

  // final ProjectDetailsPage widget;
  final void Function()? onTap;
  final String failureText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, color: AppColors.navyBlue, size: 25),

          Text(failureText),
          CustomButton(
            text: 'try again',
            bgColor: AppColors.navyBlue,
            textColor: AppColors.reallyWhite,

            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
