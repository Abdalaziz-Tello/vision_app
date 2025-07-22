import 'package:flutter/material.dart';

class LableRow extends StatelessWidget {
  const LableRow({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("*", style: TextStyle(fontSize: 15, color: Colors.red)),
        const SizedBox(width: 2),
        Text(
          title,
          style: const TextStyle(fontSize: 15, color: Color(0XFF3A433E)),
        ),
      ],
    );
  }
}
