import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/res/keys/navigation_keys.dart';
import 'package:vision_app/core/shared/entities/project_entities/project_entity.dart';
import 'package:vision_app/core/shared/widgets/projects_container/project_card.dart';
import 'package:vision_app/features/microbots_features/presentation/widgets/web_refresh_widget.dart';

class ProjectsGrid extends StatelessWidget {
  final List<ProjectEntity> projects;
  final Future<void> Function() onRefresh;
  final bool showRefreshButton;

  const ProjectsGrid({
    super.key,
    required this.projects,
    required this.onRefresh,
    this.showRefreshButton = false,
  });

  int _getCrossAxisCount(double width) {
    if (width >= 1200) return 4;
    if (width >= 900) return 3;
    if (width >= 600) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = _getCrossAxisCount(width);

    return Column(
      children: [
        if (kIsWeb && showRefreshButton) WebRefreshWidget(onRefresh: onRefresh),
        Expanded(
          child: RefreshIndicator(
            color: AppColors.whiteColor,
            backgroundColor: AppColors.navyBlue,
            onRefresh: onRefresh,
            child: GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.7,
                mainAxisExtent: 300,
              ),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return ProjectCard(
                  imageUrl: project.coverImageUrl ?? '',
                  title: project.title,
                  percentage: project.percentageCompleted / 100,
                  isVisible: project.isPublic,
                  creatorName: project.projectOwnerName,
                  onTap: () => context.push(
                    NavigationKeys.projectDetailsPageKey,
                    extra: project.id,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
