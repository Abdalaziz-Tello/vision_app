import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vision_app/core/res/color/app_colors.dart';

class CircularRotatingAnimatedDots extends StatefulWidget {
  const CircularRotatingAnimatedDots({super.key});

  @override
  State<CircularRotatingAnimatedDots> createState() =>
      _CircularRotatingAnimatedDotsState();
}

class _CircularRotatingAnimatedDotsState
    extends State<CircularRotatingAnimatedDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const _dotCount = 8, _radius = 25.0, _containerSize = 100.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _containerSize,
      width: _containerSize,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          final rotation = _controller.value * 2 * pi;

          Positioned dot(int i) {
            final angle = 2 * pi / _dotCount * i + rotation;
            final size = 12 + 2 * sin(angle);
            final dx = _radius * cos(angle);
            final dy = _radius * sin(angle);
            return Positioned(
              left: _containerSize / 2 + dx - size / 2,
              top: _containerSize / 2 + dy - size / 2,
              child: Container(
                width: size,
                height: size,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.navyBlue,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blue50,
                      offset: Offset(2, 2),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            );
          }

          return Stack(children: List.generate(_dotCount, dot));
        },
      ),
    );
  }
}
