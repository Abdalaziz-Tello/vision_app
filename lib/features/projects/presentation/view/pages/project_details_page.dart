import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_app/core/di_storage_listner/build_context_extensions.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/features/auth/presentation/state_managments/current_user_bloc/current_user_bloc.dart';
import 'package:vision_app/features/projects/presentation/state_managments/cubits/project_attachments_cubit/project_attachments_cubit.dart';
import 'package:vision_app/features/projects/presentation/state_managments/project_details_bloc/project_details_bloc.dart';
import 'package:vision_app/features/projects/presentation/view/widgets/attachment_pair_picker.dart';
import 'package:vision_app/features/projects/presentation/view/widgets/create_project_widgets/glowing_circle_with_text.dart';
import 'package:vision_app/features/projects/presentation/view/widgets/input_field_widget.dart';
import 'package:vision_app/core/widgets/projects_container/custom_circular_progress.dart';
import 'package:vision_app/features/projects/presentation/view/widgets/enumeration_item.dart';
import 'package:vision_app/features/projects/presentation/view/widgets/project_details_widgets/advanced_resource_request_banner.dart';
import 'package:vision_app/features/projects/presentation/view/widgets/project_details_widgets/project_details_appbar.dart';
import 'package:vision_app/core/widgets/project_details_failure_widget.dart';
import 'package:vision_app/core/widgets/projects_container/visible_or_not_row.dart';

//TODO : make them static
class ProjectDetailsPage extends StatefulWidget {
  final String projectId;

  const ProjectDetailsPage({super.key, required this.projectId});

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  late TextEditingController projectObjectivesController;

  @override
  void initState() {
    super.initState();
    projectObjectivesController = TextEditingController();

    // Load project details
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
      appBar: ProjectDetailsAppbar(),
      body: BlocBuilder<ProjectDetailsBloc, ProjectDetailsState>(
        builder: (context, state) {
          if (state is ProjectDetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.navyBlue),
            );
          } else if (state is ProjectDetailsFailure) {
            return ProjectDetailsFailureWidget(
              onTap: () {
                context.read<ProjectDetailsBloc>().add(
                  FetchProjectDetails(widget.projectId),
                );
              },
              failureText: state.error,
            );
          } else if (state is ProjectDetailsSuccess) {
            final project = state.project;

            return BlocBuilder<CurrentUserBloc, CurrentUserState>(
              builder: (context, userState) {
                final currentUserId = switch (userState) {
                  CurrentUserLoaded u => u.user.id,
                  _ => null,
                };

                final bool isVisitor = currentUserId != project.createdBy;
                print(
                  'isvistor : $isVisitor , currentUserId : $currentUserId , createdBy : ${project.createdBy}',
                );
                // Preload Cubit with project data
                context.read<ProjectAttachmentsCubit>().preload(
                  initialCover: project.coverImageUrl != null
                      ? PlatformFile(
                          name: 'cover.jpg',
                          size: 0,
                          path: project.coverImageUrl,
                        )
                      : null,
                  initialAttachment: project.attachments.isNotEmpty
                      ? PlatformFile(
                          name: project.attachments.first.fileName,
                          size: project.attachments.first.fileSize ?? 0,
                          path: project.attachments.first.fileUrl,
                        )
                      : null,
                );

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: context.screenHeight * 0.02),

                      EnergeticCircleWithFocus(
                        text: '${project.percentageCompleted}%',
                      ).animate().fadeIn(delay: 0.1.seconds),

                      const SizedBox(height: 10),
                      EnumerationItem(
                        text: project.title,
                        circleSize: 12,
                        circleColor: AppColors.vibrantMintGreen,
                        fontSize: 18,
                        textColor: Colors.black87,
                        isBold: true,
                      ).animate().fadeIn(delay: 0.15.seconds),

                      const SizedBox(height: 5),
                      if (project.description != null)
                        EnumerationItem(
                          text: project.description!,
                          circleSize: 10,
                          circleColor: AppColors.vibrantMintGreen,
                          fontSize: 16,
                          textColor: AppColors.gray600,
                          isBold: true,
                        ).animate().fadeIn(delay: 0.2.seconds),

                      const SizedBox(height: 5),
                      EnumerationItem(
                        text:
                            AppString.createdByLabel + project.projectOwnerName,
                        circleSize: 8,
                        circleColor: AppColors.vibrantMintGreen,
                        fontSize: 14,
                        textColor: AppColors.gray600,
                        isBold: true,
                      ).animate().fadeIn(delay: 0.25.seconds),

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
                              percentage: (project.percentageCompleted / 100)
                                  ,
                              size: 140,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                AppString.projectVisibleAfterHalfDone,
                                style: const TextStyle(
                                  color: AppColors.gray800,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 0.3.seconds),

                      const SizedBox(height: 10),

                      if (!project.isPublic)
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
                                child: Text(
                                  AppString.cannotActivateUntilApproved,
                                  style: const TextStyle(
                                    color: AppColors.navyBlue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ).animate().fadeIn(delay: 0.35.seconds),

                      const SizedBox(height: 10),
                      VisibleOrNotRow(
                        isPublic: project.isPublic,
                      ).animate().fadeIn(delay: 0.35.seconds),

                      const SizedBox(height: 10),
                      EnumerationItem(
                        text: AppString.projectObjectives,
                        circleColor: AppColors.orange,
                        fontSize: 24,
                        isBold: true,
                      ).animate().fadeIn(delay: 0.4.seconds),

                      const SizedBox(height: 5),
                      InputFieldWidget(
                        controller: projectObjectivesController,
                        hintText: '',
                      ).animate().fadeIn(delay: 0.45.seconds),

                      const SizedBox(height: 10),

                      /// Attachments Picker using Cubit
                      BlocBuilder<
                            ProjectAttachmentsCubit,
                            ProjectAttachmentsState
                          >(
                            builder: (context, attachmentState) {
                              return Center(
                                child: AttachmentPairPicker(
                                  initialCover: attachmentState.coverImage,
                                  initialPdf: attachmentState.attachment,
                                  onCoverPicked: isVisitor
                                      ? null
                                      : (file) => context
                                            .read<ProjectAttachmentsCubit>()
                                            .setCover(file),
                                  onPdfPicked: isVisitor
                                      ? null
                                      : (file) => context
                                            .read<ProjectAttachmentsCubit>()
                                            .setAttachment(file),
                                ),
                              );
                            },
                          )
                          .animate()
                          .fadeIn(delay: 0.5.seconds),

                      const SizedBox(height: 10),

                      if (!isVisitor)
                        AdvancedResourceRequestBanner(
                          project: project,
                        ).animate().fadeIn(delay: 0.55.seconds),
                    ],
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
