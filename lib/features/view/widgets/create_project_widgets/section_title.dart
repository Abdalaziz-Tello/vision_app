
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry padding;

  const SectionTitle(
    this.text, {
    super.key,
    this.padding = const EdgeInsets.all(8.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 22,
            color: Color(0XFF3A433E),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}