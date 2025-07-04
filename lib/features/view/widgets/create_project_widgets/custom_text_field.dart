import 'package:flutter/material.dart';
import 'package:vision_app/features/view/widgets/create_project_widgets/input_field_widget.dart';
import 'package:vision_app/features/view/widgets/create_project_widgets/lable_row.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool required;
  const CustomTextField({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    this.validator,
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
          InputFieldWidget(
            controller: controller,
            validator: validator,
            hintText: hintText,
          ),
        ],
      ),
    );
  }
}
