import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_app/features/projects/presentation/state_managments/cubits/dialog_form_cubit/dialog_form_cubit.dart';
import 'package:vision_app/features/projects/presentation/view/widgets/create_project_widgets/university_student_checkbox.dart';

class UniversityToggle extends StatelessWidget {
  const UniversityToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DialogFormCubit, DialogFormState>(
      builder: (context, state) {
        return UniversityStudentCheckbox(
          value: state.isUniversityStudent,
          onChanged: (val) =>
              context.read<DialogFormCubit>().toggleUniversityStudent(val),
        );
      },
    );
  }
}
