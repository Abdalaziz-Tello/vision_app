import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_app/features/auth/presentation/homePage_widgets/top_project_card.dart';
import 'package:vision_app/features/projects/presentation/top_projects_bloc/top_projects_bloc.dart';

class TopProjectsListView extends StatelessWidget {
  final List<Color> cardColors;

  const TopProjectsListView({super.key, required this.cardColors});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 250,
        child: BlocBuilder<TopProjectsBloc, TopProjectsState>(
          builder: (context, state) {
            if (state is TopProjectsFailure) {
              return Center(child: Text("خطأ: ${state.error}"));
            }

            final isLoading = state is TopProjectsLoading;
            final projects = state is TopProjectsSuccess ? state.projects : [];

            if (!isLoading && projects.isEmpty) {
              return const Center(child: Text("لا توجد مشاريع بعد"));
            }

            final itemCount = isLoading ? 3 : projects.length;

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: itemCount,
              itemBuilder: (context, index) {
                if (isLoading) {
                  final color = cardColors[index % cardColors.length];
                  return ProjectCard(isLoading: true, loadingColor: color);
                }

                final project = projects[index];
                return ProjectCard(
                  imageUrl: project.coverImageUrl,
                  title: project.title,
                  subtitle: "${project.percentageCompleted}٪ مكتمل",
                  onTap: () {
                    // TODO: Navigate to details
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
