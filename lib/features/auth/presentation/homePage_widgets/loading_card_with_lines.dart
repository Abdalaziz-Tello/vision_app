import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vision_app/core/res/color/app_colors.dart';

class LoadingCard extends StatelessWidget {
  final Color backgroundColor;

  const LoadingCard({super.key, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.reallyWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withOpacity(0.05),
              offset: Offset(0, 2),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(height: 12),
            FractionallySizedBox(
                  alignment: Alignment.centerRight,
                  widthFactor: 0.9,
                  child: Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9D9D9),
                      // borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                )
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(delay: 0.3.seconds, duration: 0.9.seconds),
            const SizedBox(height: 8),
            FractionallySizedBox(
                  alignment: Alignment.centerRight,
                  widthFactor: 0.75,
                  child: Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9D9D9),
                      // borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                )
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(delay: 0.3.seconds, duration: 0.9.seconds),
          ],
        ),
      ),
    );
  }
}
