import 'package:flutter/material.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';

class VisibleOrNotRow extends StatelessWidget {
  const VisibleOrNotRow({super.key, required this.isPublic});

  final bool isPublic;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isPublic ? Icons.lock_open_outlined : Icons.lock_outline,
          color: isPublic ? AppColors.green : AppColors.redColor,
        ),
        const SizedBox(width: 5),
        Text(
          isPublic ? AppString.visibleToPublic : AppString.notVisible,
          style: const TextStyle(
            color: AppColors.gray800,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
