import 'package:flutter/material.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/widgets/custom_loading_indicator/circular_rotating_animated_dots.dart';
import 'package:vision_app/core/widgets/custom_loading_indicator/typing_text.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularRotatingAnimatedDots(),
        const SizedBox(height: 10),
        TypingText(text: AppString.loading),
      ],
    );
  }
}
