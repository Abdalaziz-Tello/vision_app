import 'package:flutter/material.dart';
import 'package:vision_app/core/res/color/app_colors.dart';

class CustomCircularProgress extends StatelessWidget {
  final double percentage; // from 0.0 to 1.0, so we pass the percentaage/100
  final double size;
  final double strokeWidth;
  final Color activeColor;
  final Color inactiveColor;
  final TextStyle? textStyle;

  const CustomCircularProgress({
    super.key,
    required this.percentage,
    this.size = 100,
    this.strokeWidth = 3,
    this.activeColor = AppColors.green,
    this.inactiveColor = AppColors.gray200,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final clampedPercentage = percentage.clamp(0.0, 1.0);

    return Stack(
      alignment: Alignment.center,
      children: [
        CircularProgressIndicator(
          value: 1,
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(inactiveColor),
        ),

        CircularProgressIndicator(
          value: clampedPercentage.toDouble(),
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(activeColor),
          backgroundColor: AppColors.transparentColor,
        ),

        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            '${(clampedPercentage * 100).round()}%',
            style:
                textStyle ??
                TextStyle(
                  fontSize: size * 0.07,
                  fontWeight: FontWeight.bold,
                  color: activeColor,
                ),
          ),
        ),
      ],
    );
  }
}
