import 'package:flutter/material.dart';
import 'package:vision_app/core/res/color/app_colors.dart';

class TypingText extends StatefulWidget {
  final String text;
  final Duration typingDuration;
  final Duration pauseDuration;

  const TypingText({
    required this.text,
    this.typingDuration = const Duration(milliseconds: 1500),
    this.pauseDuration = const Duration(milliseconds: 500),
    super.key,
  });

  @override
  State<TypingText> createState() => _TypingTextState();
}

class _TypingTextState extends State<TypingText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<int> _typingAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.typingDuration,
      vsync: this,
    );

    _typingAnimation = StepTween(
      begin: 0,
      end: widget.text.length,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(widget.pauseDuration, () {
          if (mounted) _controller.forward(from: 0);
        });
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _typingAnimation,
      builder: (_, __) {
        return Text(
          widget.text.substring(0, _typingAnimation.value),
          textDirection: TextDirection.rtl,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.navyBlue,
            shadows: [
              BoxShadow(color: AppColors.brightBlue, offset: Offset(1, 1)),
            ],
          ),
        );
      },
    );
  }
}
