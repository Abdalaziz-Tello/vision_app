import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/shared/widgets/custom_button.dart';
import 'package:vision_app/core/shared/widgets/custom_snack_bar_function.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/domain/entities/create_project_entity.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/presentation/state_managments/create_project_bloc/create_project_bloc.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/presentation/state_managments/cubits/dialog_form_cubit/dialog_form_cubit.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/presentation/state_managments/upload_file_bloc/upload_file_bloc.dart';

class UploadButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameCtrl;
  final TextEditingController typeCtrl;
  final TextEditingController descCtrl;

  const UploadButton({
    super.key,
    required this.formKey,
    required this.nameCtrl,
    required this.typeCtrl,
    required this.descCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: BlocBuilder<DialogFormCubit, DialogFormState>(
        builder: (context, state) {
          if (state.isUploading ||
              context.watch<CreateProjectBloc>().state
                  is CreateProjectLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.navyBlue),
            );
          }

          return CustomButton(
            text: AppString.upload,
            width: 200,
            fontSize: 22,
            bgColor: const Color.fromRGBO(33, 193, 242, 1),
            textColor: AppColors.navyBlue,
            onTap: () async {
              final dialogFormState = context.read<DialogFormCubit>().state;

              if (!(formKey.currentState?.validate() ?? false) ||
                  dialogFormState.coverImage == null ||
                  dialogFormState.selectedDomainId == null ||
                  dialogFormState.selectedDomainName == null ||
                  descCtrl.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  customSnackBar(
                    AppString.pleaseEnterAllFieldsAndAddCoverImage,
                    AppColors.redColor,
                  ),
                );
                return;
              }

              final cubit = context.read<DialogFormCubit>();
              cubit.setUploading(true);

              try {
                final uploadBloc = context.read<UploadFileBloc>();
                final cover = state.coverImage!;
                final uploadedCover = await uploadBloc.uploadSingleFile(cover);
                if (uploadedCover == null) throw Exception();

                final attachments = <ProjectAttachmentEntityForcreating>[];
                for (final file in state.selectedFiles) {
                  final u = await uploadBloc.uploadSingleFile(file);
                  if (u == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      customSnackBar(
                        "فشل في رفع المرفق. يرجى المحاولة مرة أخرى.",
                        AppColors.redColor,
                      ),
                    );
                    cubit.setUploading(false);
                    return;
                  }
                  attachments.add(
                    ProjectAttachmentEntityForcreating(
                      fileUrl: u.fileUrl,
                      fileName: u.fileName,
                      fileType: u.fileType,
                      fileSize: u.fileSize,
                    ),
                  );
                }

                final entity = CreateProjectEntity(
                  title: nameCtrl.text.trim(),
                  description: descCtrl.text.trim(),
                  projectDomainId: state.selectedDomainId!,
                  isUniversityStudent: state.isUniversityStudent,
                  coverImageUrl: uploadedCover.fileUrl,
                  attachments: attachments,
                );
                context.read<CreateProjectBloc>().add(
                  CreateProjectRequested(entity),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  customSnackBar("تم إرسال المشروع بنجاح", AppColors.green),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  customSnackBar(
                    "حدث خطأ أثناء الرفع: ${e.toString()}",
                    AppColors.redColor,
                  ),
                );
              } finally {
                cubit.setUploading(false);
              }
            },
          );
        },
      ),
    );
  }
}
