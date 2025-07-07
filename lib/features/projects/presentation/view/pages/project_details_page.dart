import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vision_app/core/res/app_images.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/res/keys/app_keys.dart';
import 'package:vision_app/core/res/keys/navigation_keys.dart';
import 'package:vision_app/features/projects/presentation/project_details_bloc/project_details_bloc.dart';
import 'package:vision_app/features/projects/presentation/view/widgets/create_project_widgets/add_attachments_widget.dart';
import 'package:vision_app/features/projects/presentation/view/widgets/create_project_widgets/glowing_circle_with_text.dart';
import 'package:vision_app/features/projects/presentation/view/widgets/create_project_widgets/input_field_widget.dart';
import 'package:vision_app/features/projects/presentation/view/widgets/custom_button.dart';
import 'package:vision_app/features/projects/presentation/view/widgets/custom_circular_progress.dart';
import 'package:vision_app/features/projects/presentation/view/widgets/enumeration_item.dart';
//TODO : make them static

class ProjectDetailsPage extends StatefulWidget {
  final String projectId;

  const ProjectDetailsPage({super.key, required this.projectId});

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  late TextEditingController projectObjectivesController;
  PlatformFile? coverImage;
  List<PlatformFile> selectedFiles = [];

  @override
  void initState() {
    super.initState();
    projectObjectivesController = TextEditingController();

    // Load project by ID
    context.read<ProjectDetailsBloc>().add(
      FetchProjectDetails(widget.projectId),
    );
  }

  @override
  void dispose() {
    projectObjectivesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.reallyWhite,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        shadowColor: AppColors.whiteColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: CustomButton(
                text: 'مشاركة المشروع',
                textColor: AppColors.whiteColor,
                bgColor: AppColors.vibrantMintGreen,
                borderColor: AppColors.vibrantMintGreen,
                onTap: () async {
                  final appUrl = AppKeys.webUrl;
                  //to share the project :
                  Share.share('''
                  🌟 اكتشف منصة Vision  لمساعدة الطلاب والمهندسين وكل من لديه شغف في إنجاز المشاريع!

                  🔗 ${appUrl}
                    ''');

                  await Clipboard.setData(ClipboardData(text: appUrl));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('📋 تم نسخ رابط الموقع!')),
                  );
                },
              ),
            ),
            Image.asset(AppImages.logo, width: 120, fit: BoxFit.contain),
          ],
        ),
      ),
      body: BlocBuilder<ProjectDetailsBloc, ProjectDetailsState>(
        builder: (context, state) {
          if (state is ProjectDetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.navyBlue),
            );
          } else if (state is ProjectDetailsFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: AppColors.navyBlue, size: 25),

                  Text('Opss: ${state.error},something went wrong ..'),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProjectDetailsBloc>().add(
                        FetchProjectDetails(widget.projectId),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.reallyWhite,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "retry ",
                      style: const TextStyle(color: AppColors.navyBlue),
                    ),
                  ),
                ],
              ),
            ); //! make something to recall
          } else if (state is ProjectDetailsSuccess) {
            final project = state.project;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EnergeticCircleWithFocus(
                    text: '${project.percentageCompleted.toString()}%',
                  ).animate().fadeIn(delay: 0.1.seconds, duration: 0.2.seconds),
                  SizedBox(height: 10),
                  EnumerationItem(
                    text: project.title,
                    circleSize: 12,
                    circleColor: AppColors.vibrantMintGreen,
                    fontSize: 18,
                    textColor: Colors.black87,
                    isBold: true,
                  ).animate().fadeIn(
                    delay: 0.15.seconds,
                    duration: 0.25.seconds,
                  ),
                  SizedBox(height: 5),
                  if (project.description != null)
                    EnumerationItem(
                      text: project.description!,
                      circleSize: 10,
                      circleColor: AppColors.vibrantMintGreen,
                      fontSize: 16,
                      textColor: AppColors.gray600,
                      isBold: true,
                    ).animate().fadeIn(
                      delay: 0.2.seconds,
                      duration: 0.3.seconds,
                    ),
                  SizedBox(height: 5),
                  EnumerationItem(
                    text: 'من قبل : ' + project.projectOwnerName,
                    // 'من قبل : جميل جمال', // TODO: Replace with actual owner if available
                    circleSize: 8,
                    circleColor: AppColors.vibrantMintGreen,
                    fontSize: 14,
                    textColor: AppColors.gray600,
                    isBold: true,
                  ).animate().fadeIn(
                    delay: 0.25.seconds,
                    duration: 0.35.seconds,
                  ),
                  const SizedBox(height: 10),

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.reallyWhite,
                      border: Border.all(color: AppColors.gray100),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        CustomCircularProgress(
                          percentage: project.percentageCompleted / 100,
                          size: 140,
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'يتم عرض مشروعك عند إنجاز 50% على الأقل من المشروع',
                            style: TextStyle(
                              color: AppColors.gray800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 0.3.seconds, duration: 0.4.seconds),
                  const SizedBox(height: 10),

                  if (!project.isPublic) //! is this container depend on this ?
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.blue50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: AppColors.navyBlue,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: const Text(
                              'لا يمكنك تفعيل صفحتك حتى يوافق على مشروعك',
                              style: TextStyle(color: AppColors.navyBlue),
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(
                      delay: 0.35.seconds,
                      duration: 0.45.seconds,
                    ),

                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        project.isPublic ? Icons.visibility : Icons.lock,
                        color: AppColors.gray800,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        project.isPublic ? 'معروض للعامة' : 'غير معروض',
                        style: const TextStyle(
                          color: AppColors.gray800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ).animate().fadeIn(
                    delay: 0.35.seconds,
                    duration: 0.45.seconds,
                  ),

                  const SizedBox(height: 10),

                  EnumerationItem(
                    //TODO : make it updated
                    text: 'أهداف المشروع',
                    circleColor: AppColors.orange,
                    fontSize: 24,
                    isBold: true,
                  ).animate().fadeIn(delay: 0.4.seconds, duration: 0.5.seconds),
                  const SizedBox(height: 5),
                  InputFieldWidget(
                    controller: projectObjectivesController,
                    hintText: '',
                  ).animate().fadeIn(
                    delay: 0.45.seconds,
                    duration: 0.55.seconds,
                  ),
                  const SizedBox(height: 10),

                  //!!__________________________
                  Center(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth >= 800;

                        return Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          alignment: WrapAlignment.center,
                          children: [
                            // Cover Image Picker
                            SizedBox(
                              width: isWide
                                  ? constraints.maxWidth * 0.45
                                  : double.infinity,
                              child: AttachmentPicker(
                                title: 'اختر صورة الغلاف',
                                icon: Icons.image,
                                initialFile:
                                    coverImage ??
                                    (project.coverImageUrl != null
                                        ? PlatformFile(
                                            name:
                                                'cover.jpg', //!! the name of the image !!
                                            size: 0,
                                            path: project.coverImageUrl,
                                            bytes:
                                                null, //can load bytes if needed later
                                          )
                                        : null),
                                onPicked: (file) {
                                  setState(() {
                                    coverImage = file;
                                  });
                                },
                                isPdf: false,
                              ),
                            ),

                            //  PDF Attachment Picker
                            SizedBox(
                              width: isWide
                                  ? constraints.maxWidth * 0.45
                                  : double.infinity,
                              child: AttachmentPicker(
                                title: 'أرفق ملف PDF',
                                icon: Icons.picture_as_pdf,
                                initialFile: selectedFiles.isNotEmpty
                                    ? selectedFiles.first
                                    : (project.attachments.isNotEmpty
                                          ? PlatformFile(
                                              name: project
                                                  .attachments
                                                  .first
                                                  .fileName,
                                              size:
                                                  project
                                                      .attachments
                                                      .first
                                                      .fileSize ??
                                                  0,
                                              path: project
                                                  .attachments
                                                  .first
                                                  .fileUrl, // URL مباشر
                                              bytes:
                                                  null, // لأن الملف من الإنترنت
                                            )
                                          : null),
                                onPicked: (file) {
                                  setState(() {
                                    selectedFiles = [file]; // Allow one for now
                                  });
                                },
                                isPdf: true,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ).animate().fadeIn(delay: 0.5.seconds, duration: 0.6.seconds),

                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.reallyWhite,
                      border: Border.all(color: AppColors.gray100),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'هل ينقصك بعض الأدوات لإكمال مشروعك؟',
                            style: TextStyle(
                              color: AppColors.gray800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            context.push(
                              NavigationKeys.advancedResourcesRequestPageKey,
                              extra: {
                                NavigationKeys.projectIdKey: project.id,
                                NavigationKeys.projectTitleKey: project.title,
                                //  'projectOwner': project.,
                                NavigationKeys.completedPercentageKey:
                                    project.percentageCompleted,
                                NavigationKeys.projectFieldIdKey:
                                    project.projectDomainId,
                                NavigationKeys.projectDomainName:
                                    project.projectDomainName,
                                NavigationKeys.projectOwnerName:
                                    project.projectOwnerName,
                              },
                            );
                          },
                          child: Text(
                            'طلب موارد متقدمة',
                            style: TextStyle(
                              color: AppColors.brightBlue,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.brightBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(
                    delay: 0.55.seconds,
                    duration: 0.65.seconds,
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
