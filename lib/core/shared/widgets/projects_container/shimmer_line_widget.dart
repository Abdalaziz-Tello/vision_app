import 'package:flutter/material.dart';
import 'package:vision_app/core/res/color/app_colors.dart';

class ShimmerLineWidget extends StatelessWidget {
  final double widthFactor;
  final double shimmerHeight;
  final Color? containerColor;
  final double radius;

  const ShimmerLineWidget({
    super.key,
    required this.widthFactor,
    required this.shimmerHeight,
    this.containerColor = AppColors.gray100,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.centerRight,
      widthFactor: widthFactor,
      child: Container(
        height: shimmerHeight,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
