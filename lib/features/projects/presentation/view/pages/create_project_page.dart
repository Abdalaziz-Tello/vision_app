import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_app/core/di_storage_listner/di.dart';
import 'package:vision_app/features/projects/presentation/state_managments/cubits/dialog_form_cubit/dialog_form_cubit.dart';
import 'package:vision_app/features/projects/presentation/view/widgets/create_project_widgets/create_projects_screen_content.dart';

class CreateProjectsScreen extends StatelessWidget {
  const CreateProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DialogFormCubit>(),
      child: const CreateProjectsScreenContent(), //scafflod
    );
  }
}
