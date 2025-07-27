import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/shared/widgets/custom_loading_indicator/custom_loading_indicator.dart';
import 'package:vision_app/core/res/keys/navigation_keys.dart';
import 'package:vision_app/core/di_storage_listner/build_context_extensions.dart';
import 'package:vision_app/core/shared/widgets/project_network_image.dart';
import 'package:vision_app/features/user_features/user_projects_features/get_projects_by_user_id/presentation/user_projects_bloc/user_projects_bloc.dart';

// this responsible for show the projects of the user in the homepage screen , using user id

void showProjectsPopup(BuildContext context, String userId) {
  final screenWidth = context.screenWidth;
  final popupWidth = screenWidth.clamp(200.0, 350.0);

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Dismiss',
    barrierColor: AppColors.blackColor.withOpacity(0.2),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) {
      return Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(16),
              width: popupWidth,
              height: popupWidth, //350,
              decoration: BoxDecoration(
                color: AppColors.reallyWhite,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: AppColors.gray600, blurRadius: 12),
                ],
              ),
              child: BlocProvider.value(
                value: context.read<UserProjectsBloc>()
                  ..add(LoadUserProjects(userId)),
                child: BlocBuilder<UserProjectsBloc, UserProjectsState>(
                  builder: (context, state) {
                    if (state is UserProjectsLoading) {
                      return const Center(child: CustomLoadingIndicator());
                    } else if (state is UserProjectsError) {
                      return Center(child: Text(state.message));
                    } else if (state is UserProjectsLoaded) {
                      if (state.projects.isEmpty) {
                        return Center(
                          child: Text(AppString.noProjectsForYouYet),
                        );
                      }

                      return ListView.separated(
                        itemCount: state.projects.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          final project = state.projects[index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: ClipOval(
                              child: SizedBox(
                                width: 44,
                                height: 44,
                                child: ProjectNetworkImage(
                                  imageUrl: project.coverImageUrl,
                                  borderRadius: 100,
                                  height: 44,
                                ),
                              ),
                            ),
                            title: Text(
                              project.title,
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              'من: ${project.projectOwnerName}',
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {
                              context.pop();
                              context.push(
                                NavigationKeys.projectDetailsPageKey,
                                extra: project.id,
                              );
                            },
                          );
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
