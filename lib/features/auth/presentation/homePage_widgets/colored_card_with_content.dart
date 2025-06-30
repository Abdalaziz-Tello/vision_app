import 'package:flutter/material.dart';

class ColoredCardWithContent extends StatelessWidget {
  // final Color backgroundColor;
  final String imageAsset;
  final String title;
  final String subtitle;

  const ColoredCardWithContent({
    super.key,
    // required this.backgroundColor,
    required this.imageAsset,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0, 2),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                //  color: backgroundColor,
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(imageAsset),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: 'Mada-VariableFont_wght',
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(color: Color(0xff49B575), fontSize: 14),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
