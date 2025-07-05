import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vision_app/core/res/app_images.dart';
import 'package:vision_app/core/res/app_keys.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/features/projects/domain/entities/create_project_entity.dart';
import 'package:vision_app/features/projects/domain/entities/upload_file_entity.dart';
import 'package:vision_app/features/projects/presentation/create_project_bloc/create_project_bloc.dart';
import 'package:vision_app/features/projects/presentation/project_domains_bloc/project_domains_bloc.dart';
import 'package:vision_app/features/projects/presentation/upload_file_bloc/upload_file_bloc.dart';
import 'package:vision_app/features/view/widgets/create_project_widgets/add_attachments_widget.dart';
import 'package:vision_app/features/view/widgets/create_project_widgets/custom_text_field.dart';
import 'package:vision_app/features/view/widgets/create_project_widgets/section_title.dart';
import 'package:vision_app/features/view/widgets/create_project_widgets/pdf_picker_widget.dart';
import 'package:vision_app/features/view/widgets/create_project_widgets/cover_image_picker_widget.dart';
import 'package:vision_app/features/view/widgets/create_project_widgets/text_with_expansion_tile_selector.dart';
import 'package:vision_app/features/view/widgets/create_project_widgets/university_student_checkbox.dart';
import 'package:vision_app/features/view/widgets/custom_button.dart';

class DialogScreen extends StatefulWidget {
  const DialogScreen({super.key});

  @override
  State<DialogScreen> createState() => _DialogScreenState();
}

class _DialogScreenState extends State<DialogScreen> {
  final _formKey = GlobalKey<FormState>();

  final _projectNameController = TextEditingController();
  final _projectTypeController = TextEditingController();
  final _projectDescriptionController = TextEditingController();

  List<PlatformFile> selectedFiles = [];
  PlatformFile? coverImage;
  String? _selectedDomainId;

  bool isUniversityStudent = false;
  bool _isBlocInitialized = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isBlocInitialized) {
      _isBlocInitialized = true;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        final bloc = context.read<ProjectDomainsBloc>();
        if (bloc.state is! ProjectDomainsSuccess) {
          bloc.add(FetchProjectDomainsRequested());
        }
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        shadowColor: AppColors.whiteColor,
        //  title: const SizedBox(),
        actions: [Image.asset(AppImages.logo, width: 120, fit: BoxFit.contain)],
      ),
      backgroundColor: AppColors.whiteColor,

      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppImages.footer,
            fit: BoxFit.cover,
            width: double.infinity,
          ),

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
                child: Form(
                  key: _formKey,
                  child: BlocListener<CreateProjectBloc, CreateProjectState>(
                    listener: (context, state) {
                      if (state is CreateProjectSuccess) {
                        print(state.projectId);
                        context.push(
                          AppKeys.projectDetailsPageKey,
                          extra: state.projectId,
                        );
                      } else if (state is CreateProjectFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("خطأ: ${state.error}")),
                        );
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildTitle(),
                        const SizedBox(height: 16),
                        _buildProjectNameField(),
                        //! here is the problem !!
                        //  _buildProjectTypeField(),
                        BlocBuilder<ProjectDomainsBloc, ProjectDomainsState>(
                          builder: (context, state) {
                            List<String> options = [];
                            String placeholder = "اختر مجال المشروع";

                            // Determine the options based on state
                            if (state is ProjectDomainsLoading) {
                              options = ["جاري التحميل..."];
                            } else if (state is ProjectDomainsSuccess) {
                              options = state.domains.isEmpty
                                  ? ["لا توجد مجالات متاحة"]
                                  : state.domains.map((e) => e.name).toList();
                            } else if (state is ProjectDomainsFailure) {
                              options = ["حدث خطأ، حاول مرة أخرى"];
                            } else {
                              options = [placeholder];
                            }

                            // Determine the selected value to display
                            String selectedValue =
                                _projectTypeController.text.isEmpty
                                ? placeholder
                                : _projectTypeController.text;

                            return TextWithExpansionTileSelector(
                              label: AppString.projectField,
                              selectedValue: selectedValue,
                              options: options,
                              onSelected: (val) {
                                if (state is ProjectDomainsSuccess) {
                                  final selectedDomain = state.domains
                                      .firstWhere(
                                        (e) => e.name == val,
                                        orElse: () => state.domains.first,
                                      );

                                  setState(() {
                                    _projectTypeController.text = val;
                                    _selectedDomainId = selectedDomain.id;
                                    print(
                                      '_selectedDomainId: $_selectedDomainId',
                                    );
                                  });
                                } else {
                                  // Retry fetch on error
                                  context.read<ProjectDomainsBloc>().add(
                                    FetchProjectDomainsRequested(),
                                  );
                                }
                              },
                            );
                          },
                        ),
                        _buildProjectDescriptionField(),
                        SectionTitle(
                          AppString.addAttachments,
                          padding: const EdgeInsets.only(top: 16),
                        ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final isWide = constraints.maxWidth >= 800;
                            return _buildAttachmentSection(isWide);
                          },
                        ),
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
            ),
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

  Widget _buildProjectNameField() => CustomTextField(
    controller: _projectNameController,
    title: AppString.projectName,
    hintText: "مشروع منصة ", //TODO : what the hint text here ?
  );

  Widget _buildProjectDescriptionField() => CustomTextField(
    controller: _projectDescriptionController,
    title: AppString.projectDescription,
    hintText: "وصف المشروع...",
  );

  // Widget _buildAttachmentSection(bool isWide) {
  //   return isWide
  //       ? Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: _attachmentWidgets(),
  //         )
  //       : Column(
  //           children: _attachmentWidgets()
  //               .map(
  //                 (w) => Padding(
  //                   padding: const EdgeInsets.symmetric(vertical: 8),
  //                   child: w,
  //                 ),
  //               )
  //               .toList(),
  //         );
  // }

  // List<Widget> _attachmentWidgets() {
  //   return [
  //     PdfPickerWidget(
  //       onFilesPicked: (files) => setState(() {
  //         selectedFiles.addAll(files);
  //       }),
  //     ),
  //     CoverImagePickerWidget(
  //       currentImage: coverImage,
  //       onImagePicked: (img) => setState(() {
  //         coverImage = img;
  //       }),
  //     ),
  //   ];
  // }

  Widget _buildAttachmentSection(bool isWide) {
    final items = [
      AttachmentPicker(
        title: 'Add Cover Image',
        icon: Icons.photo,
        isPdf: false,
        initialFile: coverImage,
        onPicked: (f) => setState(() => coverImage = f),
      ),
      AttachmentPicker(
        title: 'Attach PDF',
        icon: Icons.file_present,
        isPdf: true,
        initialFile: selectedFiles.isNotEmpty ? selectedFiles.first : null,
        onPicked: (f) => setState(() {
          selectedFiles = [f];
        }),
      ),
    ];

    return isWide
        ? Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: items)
        : Column(
            children: items
                .map(
                  (w) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: w,
                  ),
                )
                .toList(),
          );
  }

  Widget _buildUploadButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: BlocBuilder<CreateProjectBloc, CreateProjectState>(
        builder: (context, state) {
          if (state is CreateProjectLoading) {
            return CircularProgressIndicator(color: AppColors.navyBlue);
          }
          return CustomButton(
            text: AppString.upload,
            width: 200,
            //  height: 50,
            fontSize: 22,
            //  borderRadius: 20,
            bgColor: const Color.fromRGBO(33, 193, 242, 1),
            textColor: AppColors.navyBlue,

            //     onTap: () {
            //       final formValid = _formKey.currentState?.validate() ?? false;
            //       if (!formValid ||
            //           coverImage == null ||
            //           _selectedDomainId == null ||
            //           // selectedFiles.isEmpty || //! don't need to be required ?
            //           _projectTypeController.text.isEmpty ||
            //           _projectDescriptionController.text.isEmpty) {
            //         ScaffoldMessenger.of(context).showSnackBar(
            //           const SnackBar(
            //             content: Text(
            //               "يرجى تعبئة جميع الحقول المطلوبة وإضافة مرفقات",
            //             ),
            //             backgroundColor: Colors.red,
            //           ),
            //         );
            //         return;
            //       }

            //       //TODO: Proceed with upload

            //       final entity = CreateProjectEntity(
            //         title: _projectNameController.text.trim(),
            //         description: _projectDescriptionController.text.trim(),
            //         projectDomainId: _selectedDomainId!,
            //         isUniversityStudent: isUniversityStudent,
            //         coverImageUrl:
            //             coverImage!.path ??
            //             '', // assume non-null //! but still must fix
            //         attachments: selectedFiles.map((file) {
            //           return ProjectAttachmentEntity(
            //             fileUrl: file.path ?? "",
            //             fileName: file.name,
            //             fileType: file.extension ?? "unknown",
            //             fileSize: file.size,
            //           );
            //         }).toList(),
            //       );

            //       context.read<CreateProjectBloc>().add(
            //         CreateProjectRequested(entity),
            //       );

            //       // ScaffoldMessenger.of(context).showSnackBar(
            //       //   const SnackBar(
            //       //     content: Text("تم التحقق من البيانات بنجاح"),
            //       //     backgroundColor: Colors.green,
            //       //   ),
            //       //  );
            //       print("تم التحقق من البيانات بنجاح project ");
            //     },

            //2:
            //
            // onTap: () async {
            //   final formValid = _formKey.currentState?.validate() ?? false;
            //   if (!formValid ||
            //       coverImage == null ||
            //       _selectedDomainId == null ||
            //       _projectTypeController.text.isEmpty ||
            //       _projectDescriptionController.text.isEmpty) {
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       const SnackBar(
            //         content: Text(
            //           "يرجى تعبئة جميع الحقول المطلوبة وإضافة مرفقات",
            //         ),
            //         backgroundColor: Colors.red,
            //       ),
            //     );
            //     return;
            //   }

            //   final uploadBloc = context.read<UploadFileBloc>();

            //   // 1. Upload cover image
            //   final coverFile = PlatformFile(
            //     name: coverImage!.name,
            //     path: coverImage!.path,
            //     size: coverImage!.size,
            //     bytes: coverImage!.bytes, // if picked with bytes
            //   );

            //   final uploadedCover = await uploadBloc.uploadSingleFile(
            //     coverFile,
            //   );

            //   if (uploadedCover == null) {
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       const SnackBar(
            //         content: Text("فشل رفع صورة الغلاف"),
            //         backgroundColor: Colors.red,
            //       ),
            //     );
            //     return;
            //   }

            //   // 2. Upload attachments
            //   List<ProjectAttachmentEntity> uploadedAttachments = [];

            //   for (final file in selectedFiles) {
            //     final uploaded = await uploadBloc.uploadSingleFile(file);
            //     if (uploaded == null) {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(
            //           content: Text("فشل رفع المرفق: ${file.name}"),
            //           backgroundColor: Colors.red,
            //         ),
            //       );
            //       return;
            //     }

            //     uploadedAttachments.add(
            //       ProjectAttachmentEntity(
            //         fileUrl: uploaded.fileUrl,
            //         fileName: uploaded.fileName,
            //         fileType: uploaded.fileType,
            //         fileSize: uploaded.fileSize,
            //       ),
            //     );
            //   }

            //   // 3. Create the project entity
            //   final entity = CreateProjectEntity(
            //     title: _projectNameController.text.trim(),
            //     description: _projectDescriptionController.text.trim(),
            //     projectDomainId: _selectedDomainId!,
            //     isUniversityStudent: isUniversityStudent,
            //     coverImageUrl: uploadedCover.fileUrl,
            //     attachments: uploadedAttachments,
            //   );

            //   // 4. Trigger CreateProjectBloc
            //   context.read<CreateProjectBloc>().add(
            //     CreateProjectRequested(entity),
            //   );

            //   print("✅ تم إرسال المشروع بنجاح");
            // },
            onTap: () async {
              final isFormValid = _formKey.currentState?.validate() ?? false;

              // Validate form fields
              if (!isFormValid ||
                  coverImage == null ||
                  _selectedDomainId == null ||
                  _projectTypeController.text.isEmpty ||
                  _projectDescriptionController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "يرجى تعبئة جميع الحقول المطلوبة وإضافة صورة الغلاف",
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              final uploadBloc = context.read<UploadFileBloc>();

              // Upload cover image
              UploadFileEntity? uploadedCover;
              try {
                final coverFile = PlatformFile(
                  name: coverImage!.name,
                  path: coverImage!.path,
                  size: coverImage!.size,
                  bytes: coverImage!.bytes,
                );

                uploadedCover = await uploadBloc.uploadSingleFile(coverFile);

                if (uploadedCover == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("فشل رفع صورة الغلاف"),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
              } catch (_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("حدث خطأ أثناء رفع صورة الغلاف"),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              // Upload optional attachments
              List<ProjectAttachmentEntity> uploadedAttachments = [];

              for (final file in selectedFiles) {
                try {
                  final uploaded = await uploadBloc.uploadSingleFile(file);

                  if (uploaded == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("فشل رفع المرفق: ${file.name}"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  uploadedAttachments.add(
                    ProjectAttachmentEntity(
                      fileUrl: uploaded.fileUrl,
                      fileName: uploaded.fileName,
                      fileType: uploaded.fileType,
                      fileSize: uploaded.fileSize,
                    ),
                  );
                } catch (_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("حدث خطأ أثناء رفع المرفق: ${file.name}"),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
              }

              // Create the project entity
              final entity = CreateProjectEntity(
                title: _projectNameController.text.trim(),
                description: _projectDescriptionController.text.trim(),
                projectDomainId: _selectedDomainId!,
                isUniversityStudent: isUniversityStudent,
                coverImageUrl: uploadedCover.fileUrl,
                attachments: uploadedAttachments,
              );

              // Call bloc to create project
              context.read<CreateProjectBloc>().add(
                CreateProjectRequested(entity),
              );

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("✅ تم إرسال المشروع بنجاح"),
                  backgroundColor: Colors.green,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
