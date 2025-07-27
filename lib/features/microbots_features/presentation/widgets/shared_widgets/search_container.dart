import 'package:flutter/material.dart';
import 'package:vision_app/core/res/color/app_colors.dart';

class SearchContainer extends StatelessWidget {
  final VoidCallback? onClose;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const SearchContainer({
    super.key,
    this.onClose,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.checkboxInactiveGreyFill,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          const Icon(Icons.search, color: AppColors.gray600),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              cursorColor: AppColors.navyBlue,
              decoration: InputDecoration(
                hintText: 'بحث...',
                hintStyle: const TextStyle(color: AppColors.gray600),
                border: InputBorder.none,
              ),
            ),
          ),
          if (onClose != null)
            IconButton(
              icon: const Icon(Icons.close, size: 20),
              color: AppColors.gray600,
              onPressed: onClose,
            ),
        ],
      ),
    );
  }
}
