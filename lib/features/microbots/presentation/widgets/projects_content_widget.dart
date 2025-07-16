//TODO : this have to be just if he refresh it , not every time
// also this should be

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/res/keys/navigation_keys.dart';
import 'package:vision_app/core/widgets/project_details_failure_widget.dart';
import 'package:vision_app/core/widgets/projects_container/project_card.dart';
import 'package:vision_app/features/projects/presentation/state_managments/get_all_projects_bloc/all_projects_bloc.dart';

class ProjectsContent extends StatefulWidget {
  const ProjectsContent({super.key});

  @override
  State<ProjectsContent> createState() => _ProjectsContentState();
}

class _ProjectsContentState extends State<ProjectsContent> {


  @override
  void initState() {
    super.initState();
    context.read<AllProjectsBloc>().add(FetchAllProjects());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllProjectsBloc, AllProjectsState>(
      builder: (context, state) {
        if (state is AllProjectsSuccess) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              final crossAxisCount = screenWidth >= 1200
                  ? 4
                  : screenWidth >= 900
                  ? 3
                  : 2;

              return GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.7,
                  mainAxisExtent:
                      300, //! it must match the content , change it <<
                ),
                itemCount: state.projects.length,
                itemBuilder: (context, index) {
                  final project = state.projects[index];
                  return ProjectCard(
                    imageUrl: project.coverImageUrl!,
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
              );
            },
          );
        } else if (state is AllProjectsFailure) {
          return ProjectDetailsFailureWidget(
            onTap: () {
              print(state.error);
            },
            failureText: state.error,
          );
        }
        return const Center(
          child: CircularProgressIndicator(color: AppColors.navyBlue),
        );
      },
    );
  }
}
