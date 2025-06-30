import 'package:flutter/material.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/features/view/widgets/create_project_widgets/lable_row.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const CustomTextField({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LableRow(title: title),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
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
          ),
        ],
      ),
    );
  }
}
