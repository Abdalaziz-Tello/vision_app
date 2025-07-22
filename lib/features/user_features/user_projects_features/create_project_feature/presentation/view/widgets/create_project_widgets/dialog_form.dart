import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/res/keys/navigation_keys.dart';
import 'package:vision_app/core/shared/widgets/custom_snack_bar_function.dart';
import 'package:vision_app/core/shared/widgets/custom_text_field.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/presentation/state_managments/create_project_bloc/create_project_bloc.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/presentation/view/widgets/create_project_widgets/attachment_section.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/presentation/view/widgets/create_project_widgets/project_type_selector.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/presentation/view/widgets/create_project_widgets/section_title.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/presentation/view/widgets/create_project_widgets/university_toggle.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/presentation/view/widgets/create_project_widgets/upload_button.dart';

class DialogForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController projectNameController;
  final TextEditingController projectTypeController;
  final TextEditingController projectDescriptionController;

  const DialogForm({
    super.key,
    required this.formKey,
    required this.projectNameController,
    required this.projectTypeController,
    required this.projectDescriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateProjectBloc, CreateProjectState>(
      listener: (context, state) {
        if (state is CreateProjectSuccess) {
          context.push(
            NavigationKeys.projectDetailsPageKey,
            extra: state.projectId,
          );
        } else if (state is CreateProjectFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(customSnackBar(state.error, AppColors.redColor));

          //  SnackBar(content: Text("خطأ: ${state.error}")));
        }
      },
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppString.createFirstProject,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3A433E),
              ),
            ).animate().fadeIn(delay: 0.1.seconds, duration: 0.2.seconds),
            const SizedBox(height: 16),
            CustomTextField(
              controller: projectNameController,
              title: AppString.projectName,
              hintText: 'مشروع منصة',
            ).animate().fadeIn(delay: 0.15.seconds, duration: 0.25.seconds),
            const SizedBox(height: 12),
            ProjectTypeSelector().animate().fadeIn(
              delay: 0.2.seconds,
              duration: 0.3.seconds,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: projectDescriptionController,
              title: AppString.projectDescription,
              hintText: 'منصة لاستيراد و تصدير القطع الصناعية و صمامات النفط',
            ).animate().fadeIn(delay: 0.25.seconds, duration: 0.35.seconds),
            const SizedBox(height: 16),
            SectionTitle(
              AppString.addAttachments,
            ).animate().fadeIn(delay: 0.3.seconds, duration: 0.4.seconds),
            const AttachmentSection().animate().fadeIn(
              delay: 0.35.seconds,
              duration: 0.45.seconds,
            ),

            //             AttachmentPairPicker(
            //   initialCover: state.coverImage,
            //   initialPdf: state.selectedFiles.isNotEmpty ? state.selectedFiles.first : null,
            //   onCoverPicked: cubit.setCoverImage,
            //   onPdfPicked: (file) => cubit.setAttachments([file]),
            // ),
            const SizedBox(height: 10),
            const UniversityToggle().animate().fadeIn(
              delay: 0.4.seconds,
              duration: 0.5.seconds,
            ),
            const SizedBox(height: 10),
            UploadButton(
              formKey: formKey,
              nameCtrl: projectNameController,
              typeCtrl: projectTypeController,
              descCtrl: projectDescriptionController,
            ).animate().fadeIn(delay: 0.45.seconds, duration: 0.55.seconds),
          ],
        ),
      ),
    );
  }
}
