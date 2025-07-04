import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vision_app/core/res/color/app_colors.dart';

class EnergeticCircleWithFocus extends StatefulWidget {
  const EnergeticCircleWithFocus({super.key});

  @override
  State<EnergeticCircleWithFocus> createState() =>
      _EnergeticCircleWithFocusState();
}

class _EnergeticCircleWithFocusState extends State<EnergeticCircleWithFocus>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 220,
        height: 220,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Irregular animated aura
            AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return CustomPaint(
                  size: const Size(200, 200),
                  painter: EnergyAuraPainter(progress: _controller.value),
                );
              },
            ),

            // Main circle
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: const Text(
                '25%',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.navyBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EnergyAuraPainter extends CustomPainter {
  final double progress;
  EnergyAuraPainter({required this.progress});

  //final Random _random = Random();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.brightBlue.withOpacity(
        0.2 + 0.2 * sin(progress * 2 * pi),
      )
      ..style = PaintingStyle.fill;

    final Offset center = Offset(size.width / 2, size.height / 2);
    const int pointCount = 60;
    final double baseRadius = 60 + 10 * sin(progress * 2 * pi);

    final Path path = Path();
    for (int i = 0; i <= pointCount; i++) {
      final double angle = (2 * pi * i) / pointCount;
      final double noise = sin(angle * 4 + progress * 6 * pi) * 8;
      final double radius = baseRadius + noise;
      final Offset point = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant EnergyAuraPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
