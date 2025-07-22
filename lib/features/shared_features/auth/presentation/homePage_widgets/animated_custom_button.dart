import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vision_app/core/shared/widgets/custom_button.dart';

class AnimatedCustomButton extends StatefulWidget {
  final String text;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final double? fontSize;
  final bool enableHoverEffect;
  final double hoverScale;

  const AnimatedCustomButton({
    super.key,
    required this.text,
    required this.bgColor,
    required this.textColor,
    required this.onTap,
    this.width,
    this.height,
    this.fontSize,
    this.enableHoverEffect = true,
    this.hoverScale = 1.05,
  });

  @override
  AnimatedCustomButtonState createState() => AnimatedCustomButtonState();
}

class AnimatedCustomButtonState extends State<AnimatedCustomButton>
    with TickerProviderStateMixin {
  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
  }

  void triggerShake() {
    _shakeController.reset();
    _shakeController.forward();
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomButton(
          text: widget.text,
          bgColor: widget.bgColor,
          textColor: widget.textColor,
          onTap: widget.onTap,
          height: widget.height,
          width: widget.width,
          fontSize: widget.fontSize,
          enableHoverEffect: widget.enableHoverEffect,
          hoverScale: widget.hoverScale,
        )
        .animate(controller: _shakeController)
        .shake(hz: 4, curve: Curves.easeInOut, duration: 400.ms);
  }
}
