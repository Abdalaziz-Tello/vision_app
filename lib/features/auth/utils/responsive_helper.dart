import 'package:flutter/material.dart';

class ResponsiveHelper {
  static double getDialogWidth(double screenWidth) {
    if (screenWidth <= 600) return screenWidth * 0.95;
    if (screenWidth <= 1024) return screenWidth * 0.7;
    if (screenWidth <= 1440) return screenWidth * 0.5;
    return screenWidth * 0.5;
  }

  static EdgeInsets getDialogPadding(double screenWidth) {
    return screenWidth <= 600
        ? const EdgeInsets.all(16)
        : const EdgeInsets.all(24);
  }
}
