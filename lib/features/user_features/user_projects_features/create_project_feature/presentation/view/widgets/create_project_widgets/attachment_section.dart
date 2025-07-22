import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_app/core/di_storage_listner/build_context_extensions.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/presentation/state_managments/cubits/dialog_form_cubit/dialog_form_cubit.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/presentation/view/widgets/create_project_widgets/add_attachments_widget.dart';

class AttachmentSection extends StatelessWidget {
  const AttachmentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DialogFormCubit>();
    return BlocBuilder<DialogFormCubit, DialogFormState>(
      builder: (context, state) {
        Widget cover = AttachmentPicker(
          title: AppString.addCoverImage,
          icon: Icons.photo,
          isPdf: false,
          initialFile: state.coverImage,
          onPicked: cubit.setCoverImage,
        );
        Widget attachments = AttachmentPicker(
          title: AppString.addAttachments,
          icon: Icons.file_present,
          isPdf: true,
          initialFile: state.selectedFiles.isNotEmpty
              ? state.selectedFiles.first
              : null,
          onPicked: (file) => cubit.setAttachments([file]),
        );
        final isWide = context.screenWidth >= 800;
        return isWide
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [cover, attachments],
              )
            : Column(children: [cover, const SizedBox(height: 8), attachments]);
      },
    );
  }
}
