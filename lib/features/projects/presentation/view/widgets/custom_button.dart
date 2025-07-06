import 'package:flutter/material.dart';
import 'package:vision_app/core/res/color/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color bgColor;
  final Color textColor;
  final double width;
  final double height;
  final double fontSize;
  final double borderRadius;
  final EdgeInsets margin;
  final Color borderColor;

  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.bgColor = Colors.blue,
    this.textColor = Colors.white,
    this.width = 160,
    this.height = 40,
    this.fontSize = 14,
    this.borderRadius = 10,
    this.margin = const EdgeInsets.symmetric(horizontal: 4),
    this.borderColor = AppColors.lightBlue, // fallback for AppColors.lightBlue
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
             border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
