import 'package:flutter/material.dart';

SnackBar customSnackBar(String text, Color backgroundColor) {
  return SnackBar(
    content: Text(text),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 2),
  );
}
