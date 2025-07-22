//TODO : this have to be just if he refresh it , not every time
// also this should be
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/shared/widgets/failure_widget.dart';
import 'package:vision_app/features/microbots_features/presentation/widgets/projects_widgets/projects_grid.dart';
import 'package:vision_app/features/microbots_features/get_all_projects_feature/presentation/get_all_projects_bloc/all_projects_bloc.dart';

class ProjectsContent extends StatefulWidget {
  const ProjectsContent({super.key});

  @override
  State<ProjectsContent> createState() => _ProjectsContentState();
}

class _ProjectsContentState extends State<ProjectsContent>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool _hasLoaded = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!_hasLoaded) {
        _hasLoaded = true;
        context.read<AllProjectsBloc>().add(FetchAllProjects());
      }
    });
  }

  Future<void> _onRefresh() async {
    context.read<AllProjectsBloc>().add(FetchAllProjects());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<AllProjectsBloc, AllProjectsState>(
      builder: (context, state) {
        if (state is AllProjectsSuccess) {
          return ProjectsGrid(
            projects: state.projects,
            onRefresh: _onRefresh,
            showRefreshButton: _hasLoaded,
          );
        } else if (state is AllProjectsFailure) {
          return FailureWidget(onTap: _onRefresh, failureText: state.error);
        }

        return const Center(
          child: CircularProgressIndicator(color: AppColors.navyBlue),
        );
      },
    );
  }
}
