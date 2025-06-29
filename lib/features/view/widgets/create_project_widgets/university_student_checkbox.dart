import 'package:flutter/material.dart';
import 'package:vision_app/core/res/app_string.dart';

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
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          AppString.universityStudent,
          style: const TextStyle(fontSize: 22, color: Color(0xFF2D332F)),
        ),
        Checkbox(
          value: value,
          onChanged: (val) => onChanged(val ?? false),
          side: const BorderSide(),
        ),
      ],
    );
  }
}
