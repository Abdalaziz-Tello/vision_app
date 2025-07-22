import 'package:flutter/material.dart';
import 'package:vision_app/core/res/color/app_colors.dart';

class EnergeticCircleWithFocus extends StatefulWidget {
  final String text;
  const EnergeticCircleWithFocus({super.key, required this.text});

  @override
  State<EnergeticCircleWithFocus> createState() =>
      _EnergeticCircleWithFocusState();
}

class _EnergeticCircleWithFocusState extends State<EnergeticCircleWithFocus>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shadowBlur;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    _shadowBlur = Tween<double>(
      begin: 6,
      end: 20,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _shadowBlur,
        builder: (context, child) {
          return Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.brightBlue,
                  blurRadius: _shadowBlur.value,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: child,
          );
        },
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.navyBlue,
              shadows: [
                Shadow(
                  offset: Offset(2, 3),
                  blurRadius: 1,
                  color: AppColors.brightBlue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
