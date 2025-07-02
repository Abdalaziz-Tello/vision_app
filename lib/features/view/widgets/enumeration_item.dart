import 'package:flutter/material.dart';

class EnumerationItem extends StatelessWidget {
  final String text;
  final double circleSize;
  final Color circleColor;
  final double fontSize;
  final Color textColor;
  final bool isBold;

  const EnumerationItem({
    super.key,
    required this.text,
    this.circleSize = 10,
    this.circleColor = Colors.green,
    this.fontSize = 16,
    this.textColor = Colors.black,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
