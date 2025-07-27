import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:vision_app/core/di_storage_listner/build_context_extensions.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/res/keys/navigation_keys.dart';
import 'package:vision_app/core/shared/entities/project_entities/project_entity.dart';
import 'package:vision_app/core/shared/widgets/projects_container/project_card.dart';
import 'package:vision_app/features/microbots_features/presentation/widgets/shared_widgets/refresh_and_search_row.dart';

class ProjectsGrid extends StatefulWidget {
  final List<ProjectEntity> projects;
  final Future<void> Function() onRefresh;
  final bool showRefreshButton;

  const ProjectsGrid({
    super.key,
    required this.projects,
    required this.onRefresh,
    this.showRefreshButton = false,
  });

  @override
  State<ProjectsGrid> createState() => _ProjectsGridState();
}

class _ProjectsGridState extends State<ProjectsGrid> {
  late ScrollController _scrollController;
  late TextEditingController _searchController;
  late ValueNotifier<String> _searchTextNotifier;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _searchController = TextEditingController();
    _searchTextNotifier = ValueNotifier('');
    _searchController.addListener(() {
      _searchTextNotifier.value = _searchController.text;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _searchTextNotifier.dispose();
    super.dispose();
  }

  int _getCrossAxisCount(double width) {
    if (width >= 1200) return 4;
    if (width >= 900) return 3;
    if (width >= 600) return 2;
    return 1;
  }

  List<ProjectEntity> _filterProjects(String query) {
    if (query.isEmpty) return widget.projects;

    return widget.projects.where((project) {
      return project.title.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final width = context.screenWidth;
    final crossAxisCount = _getCrossAxisCount(width);

    return Column(
      children: [
        RefreshAndSearchRow(
          onRefresh: widget.onRefresh,
          searchController: _searchController,
          onSearchChanged: (value) {}, //no need because its value notifier
          onSearchCleared: () {
            _searchController.clear(); // Triggers the listener
          },
        ),
        Expanded(
          child: ValueListenableBuilder<String>(
            valueListenable: _searchTextNotifier,
            builder: (context, searchText, _) {
              final filteredProjects = _filterProjects(searchText);

              if (filteredProjects.isEmpty) {
                return Center(
                  child: Text(
                    AppString.noResultsFoundForYourSearch,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge, //TODO : change this
                  ),
                );
              }

              return RefreshIndicator(
                color: AppColors.whiteColor,
                backgroundColor: AppColors.navyBlue,
                onRefresh: widget.onRefresh,
                child: GridView.builder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.7,
                    mainAxisExtent: 300,
                  ),
                  itemCount: filteredProjects.length,
                  itemBuilder: (context, index) {
                    final project = filteredProjects[index];
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
                    ).animate().scale(
                      duration: (0.1 * index).seconds,
                      delay: (0.1 * index).seconds,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
