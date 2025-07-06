import 'package:flutter/material.dart';
import 'package:vision_app/features/projects/presentation/view/widgets/create_project_widgets/lable_row.dart';

class CustomDisplayField extends StatelessWidget {
  final String title;
  final String value;
  final bool required;

  const CustomDisplayField({
    super.key,
    required this.title,
    required this.value,
    this.required = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          required
              ? LableRow(title: title)
              : Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0XFF3A433E),
                  ),
                ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromRGBO(228, 228, 228, 1),
            ),
            child: Text(
              value.isNotEmpty ? value : '—',
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
