import 'package:flutter/material.dart';
import 'package:vision_app/core/res/color/app_colors.dart';

class EnumerationItem extends StatelessWidget {
  final String text;
  final double circleSize;
  final Color circleColor;
  final double fontSize;
  final Color textColor;
  final bool isBold;

  const EnumerationItem({
    super.key,
    required this.text,
    this.circleSize = 10,
    this.circleColor = AppColors.green,
    this.fontSize = 16,
    this.textColor = AppColors.blackColor,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              color: textColor,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
