import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_app/core/res/app_images.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/presentation/state_managments/project_domains_bloc/project_domains_bloc.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/presentation/view/widgets/create_project_widgets/create_projects_appbar.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/presentation/view/widgets/create_project_widgets/dialog_form.dart';

class CreateProjectsScreenContent extends StatefulWidget {
  const CreateProjectsScreenContent({super.key});

  @override
  State<CreateProjectsScreenContent> createState() =>
      _CreateProjectsScreenContentState();
}

class _CreateProjectsScreenContentState
    extends State<CreateProjectsScreenContent> {
  final _formKey = GlobalKey<FormState>();
  final _projectNameController = TextEditingController();
  final _projectTypeController = TextEditingController();
  final _projectDescriptionController = TextEditingController();

  bool _blocInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_blocInitialized) {
      _blocInitialized = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<ProjectDomainsBloc>().add(FetchProjectDomainsRequested());
      });
    }
  }

  @override
  void dispose() {
    _projectNameController.dispose();
    _projectTypeController.dispose();
    _projectDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CreateProjectsAppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(AppImages.footer, fit: BoxFit.cover),
          Center(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: DialogForm(
                  formKey: _formKey,
                  projectNameController: _projectNameController,
                  projectTypeController: _projectTypeController,
                  projectDescriptionController: _projectDescriptionController,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
