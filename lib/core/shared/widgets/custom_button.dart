import 'package:flutter/material.dart';
import 'package:vision_app/core/res/color/app_colors.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  final Color bgColor;
  final Color textColor;
  final double? width;
  final double? height;
  final double? fontSize;
  final double borderRadius;
  final EdgeInsets margin;
  final Color borderColor;
  final bool enableHoverEffect;
  final double hoverScale;

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
    this.borderColor = AppColors.lightBlue,
    this.enableHoverEffect = false,
    this.hoverScale = 1.05,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) =>
          widget.enableHoverEffect ? setState(() => _isHovering = true) : null,
      onExit: (event) =>
          widget.enableHoverEffect ? setState(() => _isHovering = false) : null,
      child: AnimatedScale(
        scale: _isHovering ? widget.hoverScale : 1.0,
        duration: const Duration(milliseconds: 200),
        child: InkWell(
          onTap: widget.onTap,
          child: Container(
            width: widget.width,
            height: widget.height,
            margin: widget.margin,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: widget.bgColor,
              border: Border.all(color: widget.borderColor),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            child: Text(
              widget.text,
              style: TextStyle(
                color: widget.textColor,
                fontSize: widget.fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
