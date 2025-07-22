import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:vision_app/core/di_storage_listner/build_context_extensions.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/presentation/view/widgets/create_project_widgets/add_attachments_widget.dart';

class AttachmentPairPicker extends StatelessWidget {
  final PlatformFile? initialCover;
  final PlatformFile? initialPdf;
  final void Function(PlatformFile)? onCoverPicked;
  final void Function(PlatformFile)? onPdfPicked;

  const AttachmentPairPicker({
    super.key,
    required this.initialCover,
    required this.initialPdf,
    required this.onCoverPicked,
    required this.onPdfPicked,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = context.screenWidth >= 800;

    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: [
        SizedBox(
          width: isWide ? context.screenWidth * 0.45 : double.infinity,
          child: AttachmentPicker(
            title: AppString.addCoverImage,
            icon: Icons.image,
            isPdf: false,
            initialFile: initialCover,
            onPicked: onCoverPicked,
          ),
        ),
        SizedBox(
          width: isWide ? context.screenWidth * 0.45 : double.infinity,
          child: AttachmentPicker(
            title: AppString.addAttachments,
            icon: Icons.picture_as_pdf,
            isPdf: true,
            initialFile: initialPdf,
            onPicked: onPdfPicked,
          ),
        ),
      ],
    );
  }
}
