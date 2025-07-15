import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vision_app/core/res/keys/navigation_keys.dart';
import 'package:vision_app/core/di_storage_listner/di.dart';
import 'package:vision_app/features/auth/presentation/state_managments/current_user_bloc/current_user_bloc.dart';
import 'package:vision_app/features/projects/presentation/state_managments/create_project_bloc/create_project_bloc.dart';
import 'package:vision_app/features/projects/presentation/state_managments/cubits/project_attachments_cubit/project_attachments_cubit.dart';
import 'package:vision_app/features/projects/presentation/state_managments/project_details_bloc/project_details_bloc.dart';
import 'package:vision_app/features/projects/presentation/state_managments/project_domains_bloc/project_domains_bloc.dart';
import 'package:vision_app/features/projects/presentation/state_managments/top_projects_bloc/top_projects_bloc.dart';
import 'package:vision_app/features/projects/presentation/state_managments/upload_file_bloc/upload_file_bloc.dart';
import 'package:vision_app/features/projects/presentation/view/pages/create_project_page.dart';
import 'package:vision_app/features/resources_feature/presentation/academic_bloc/academic_bloc.dart';
import 'package:vision_app/features/resources_feature/presentation/requested_resource_bloc/requested_resource_bloc.dart';
import 'package:vision_app/features/resources_feature/presentation/resource_request_bloc/resource_request_bloc.dart';
import 'package:vision_app/features/auth/presentation/home_page.dart';
import 'package:vision_app/features/projects/presentation/view/pages/project_details_page.dart';
import 'package:vision_app/features/resources_feature/presentation/view/advanced_resources_request_page.dart';
import 'package:vision_app/features/microbots/microbots_admin.dart';

class Routes {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: NavigationKeys.homePageKey,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => sl<CurrentUserBloc>(), //!fix this
              ),
              BlocProvider(
                create: (_) => sl<TopProjectsBloc>()..add(FetchTopProjects()),
              ),
            ],
            child: HomePage(),
          ),
          transitionsBuilder: _fadeTransition,
        ),
      ),
      GoRoute(
        path: NavigationKeys.createProjectPageKey,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey, //! must fix here
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<ProjectDomainsBloc>()),
              BlocProvider(create: (_) => sl<CreateProjectBloc>()),
              BlocProvider(create: (_) => sl<UploadFileBloc>()),
            ],
            child: CreateProjectsScreen(),
          ),
          transitionsBuilder: _fadeTransition,
        ),
      ),
      GoRoute(
        path: NavigationKeys.advancedResourcesRequestPageKey,
        pageBuilder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return CustomTransitionPage(
            key: state.pageKey,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => sl<AcademicBloc>()),
                BlocProvider(create: (_) => sl<ResourceBloc>()),
                BlocProvider(create: (_) => sl<ResourceRequestBloc>()),
              ],
              child: AdvancedResourcesRequestPage(
                projectId:
                    data[NavigationKeys
                        .projectIdKey], //!TODO : put these keys to the Appkeys class
                projectTitle: data[NavigationKeys.projectTitleKey],
                //  projectOwner: data['projectOwner'],
                completedPercentage:
                    data[NavigationKeys.completedPercentageKey],
                projectFieldId: data[NavigationKeys.projectFieldIdKey],
                projectDomainName: data[NavigationKeys.projectDomainName],
                projectOwnerName: data[NavigationKeys.projectOwnerName],
              ),
            ),
            transitionsBuilder: _fadeTransition,
          );
        },
      ),
      GoRoute(
        path: NavigationKeys.projectDetailsPageKey,
        pageBuilder: (context, state) {
          final projectId = state.extra as String;
          return CustomTransitionPage(
            key: state.pageKey,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => sl<ProjectDetailsBloc>()),
                BlocProvider(
                  create: (_) => sl<CurrentUserBloc>()..add(LoadCurrentUser()),
                ),
                BlocProvider(create: (_) => sl<ProjectAttachmentsCubit>()),
              ],
              child: ProjectDetailsPage(projectId: projectId),
            ),
            transitionsBuilder: _fadeTransition,
          );
        },
      ),

      GoRoute(
        path: NavigationKeys.microboostHomePage,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: MicrobotsAdminPage(),
          transitionsBuilder: _fadeTransition,
        ),
      ),
    ],
  );
  static Widget _fadeTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const curve = Curves.easeInOut;
    var fadeTween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

    return FadeTransition(opacity: animation.drive(fadeTween), child: child);
  }
}
