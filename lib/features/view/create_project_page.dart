import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:vision_app/core/res/app_images.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/features/view/widgets/create_project_widgets/custom_text_field.dart';
import 'package:vision_app/features/view/widgets/create_project_widgets/section_title.dart';
import 'package:vision_app/features/view/widgets/create_project_widgets/pdf_picker_widget.dart';
import 'package:vision_app/features/view/widgets/create_project_widgets/cover_image_picker_widget.dart';
import 'package:vision_app/features/view/widgets/create_project_widgets/university_student_checkbox.dart';

class DialogScreen extends StatefulWidget {
  const DialogScreen({super.key});

  @override
  State<DialogScreen> createState() => _DialogScreenState();
}

class _DialogScreenState extends State<DialogScreen> {
  final _projectNameController = TextEditingController();
  final _projectTypeController = TextEditingController();
  final _projectDescriptionController = TextEditingController();

  List<PlatformFile> selectedFiles = [];
  PlatformFile? coverImage;
  bool isUniversityStudent = false;

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
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppImages.footer,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 800;
              return Center(
                child: SingleChildScrollView(
                  child: Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: AppColors.whiteColor,
                    insetPadding: const EdgeInsets.all(30),

                    child: Container(
                      width: isWide ? 700 : double.infinity,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildTitle(),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: _projectNameController,
                            title: AppString.projectName,
                            hintText: "مشروع منصة استيراد وتصدير",
                          ),
                          CustomTextField(
                            controller: _projectTypeController,
                            title: AppString.projectField,
                            hintText: "برمجة ويب",
                          ),
                          CustomTextField(
                            controller: _projectDescriptionController,
                            title: AppString.projectDescription,
                            hintText:
                                "منصة لاستيراد و تصدير القطع الصناعية و صمامات النفط",
                          ),
                          SectionTitle(
                            AppString.addAttachments,
                            padding: const EdgeInsets.only(top: 16),
                          ),
                          _buildAttachmentSection(isWide),
                          const SizedBox(height: 10),
                          UniversityStudentCheckbox(
                            value: isUniversityStudent,
                            onChanged: (val) =>
                                setState(() => isUniversityStudent = val),
                          ),
                          const SizedBox(height: 10),
                          _buildUploadButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      AppString.createFirstProject,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF3A433E),
      ),
    );
  }

  Widget _buildAttachmentSection(bool isWide) {
    return isWide
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _attachmentWidgets(),
          )
        : Column(
            children: _attachmentWidgets()
                .map(
                  (w) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: w,
                  ),
                )
                .toList(),
          );
  }

  List<Widget> _attachmentWidgets() {
    return [
      PdfPickerWidget(
        onFilesPicked: (files) => setState(() {
          selectedFiles.addAll(files);
        }),
      ),
      CoverImagePickerWidget(
        currentImage: coverImage,
        onImagePicked: (img) => setState(() {
          coverImage = img;
        }),
      ),
    ];
  }

  Widget _buildUploadButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: InkWell(
        onTap: () {
          // TODO: Handle actual upload logic
        },
        child: Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(33, 193, 242, 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              AppString.upload,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
