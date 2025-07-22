import 'package:flutter/material.dart';
import 'package:vision_app/core/di_storage_listner/build_context_extensions.dart';
import 'package:vision_app/core/shared/widgets/lable_row.dart';
import 'package:vision_app/core/shared/widgets/input_field_widget.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool required;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    this.validator,
    this.required = true,
    this.isPassword = false,
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
                  style: TextStyle(
                    fontSize: context.screenWidth * 0.2,
                    color: Color(0XFF3A433E),
                  ),
                ),
          const SizedBox(height: 10),
          InputFieldWidget(
            controller: controller,
            validator: validator,
            hintText: hintText,
            isPassword: isPassword, // pass here
          ),
        ],
      ),
    );
  }
}
