import 'package:flutter/material.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';

class UniversityStudentCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const UniversityStudentCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          hoverColor: AppColors.lightGrey,
          checkColor: AppColors.reallyWhite,
          fillColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.navyBlue;
            }
            return AppColors.checkboxInactiveGreyFill;
          }),
          value: value,
          onChanged: (val) => onChanged(val ?? false),
          side: BorderSide(
            color: value ? AppColors.navyBlue : Colors.transparent,
          ),
        ),
        Text(
          AppString.universityStudent,
          style: const TextStyle(fontSize: 22, color: Color(0xFF2D332F)),
        ),
      ],
    );
  }
}
