import 'package:flutter/material.dart';
import 'package:vision_app/core/res/color/app_colors.dart';

class InputFieldWidget extends StatelessWidget {
  const InputFieldWidget({
    super.key,
    required this.controller,
    this.validator,
    required this.hintText,
  });

  final TextEditingController controller;
  final String? Function(String? p1)? validator;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromRGBO(228, 228, 228, 1),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        cursorColor: AppColors.navyBlue,
        // validator: (value) {
        //   if (value == null || value.trim().isEmpty) {
        //     return 'هذا الحقل مطلوب';
        //   }
        //   return null;
        // },
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
