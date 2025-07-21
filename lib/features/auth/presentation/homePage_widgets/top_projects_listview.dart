import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/keys/navigation_keys.dart';
import 'package:vision_app/core/widgets/failure_widget.dart';
import 'package:vision_app/core/widgets/projects_container/project_card.dart';
import 'package:vision_app/core/widgets/projects_container/project_card_shimmer.dart';
import 'package:vision_app/features/projects/presentation/state_managments/top_projects_bloc/top_projects_bloc.dart';

class TopProjectsListView extends StatelessWidget {
  final List<Color> cardColors;

  const TopProjectsListView({super.key, required this.cardColors});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 300,
        child: BlocBuilder<TopProjectsBloc, TopProjectsState>(
          builder: (context, state) {
            if (state is TopProjectsFailure) {
              // return Center(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       IconButton(
              //         onPressed: () {
              //           context.read<TopProjectsBloc>().add(FetchTopProjects());
              //         },
              //         icon: Icon(Icons.bug_report, color: AppColors.redColor),
              //       ), //TODO : changge this icon
              //       Text("خطأ: ${state.error}"),
              //     ],
              //   ),

              // );
              return FailureWidget(
                onTap: () {
                  context.read<TopProjectsBloc>().add(FetchTopProjects());
                },
                failureText: state.error,
              );
            }

            final isLoading = state is TopProjectsLoading;
            final projects = state is TopProjectsSuccess ? state.projects : [];

            if (!isLoading && projects.isEmpty) {
              return Center(child: Text(AppString.noProjectsYet));
            }

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: isLoading ? 3 : projects.length,
              itemBuilder: (context, index) {
                if (isLoading) {
                  return ProjectCardShimmer(color: cardColors[index]);
                }

                final project = projects[index];
                return ProjectCard(
                  imageUrl: project.coverImageUrl,
                  title: project.title,
                  //  subtitle: "${project.percentageCompleted}٪ مكتمل",
                  percentage: project.percentageCompleted / 100,
                  isVisible: project.isPublic,
                  creatorName: project.projectOwnerName ?? "",
                  onTap: () {
                    // TODO: Navigate to details
                    context.push(
                      NavigationKeys.projectDetailsPageKey,
                      extra: project.id,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    ).animate().fadeIn(delay: 0.35.seconds, duration: 0.45.seconds);
  }
}
