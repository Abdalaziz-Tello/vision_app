import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vision_app/core/res/app_keys.dart';
import 'package:vision_app/core/storage/di.dart';
import 'package:vision_app/features/auth/presentation/current_user_bloc/current_user_bloc.dart';
import 'package:vision_app/features/projects/presentation/create_project_bloc/create_project_bloc.dart';
import 'package:vision_app/features/projects/presentation/project_details_bloc/project_details_bloc.dart';
import 'package:vision_app/features/projects/presentation/project_domains_bloc/project_domains_bloc.dart';
import 'package:vision_app/features/projects/presentation/upload_file_bloc/upload_file_bloc.dart';
import 'package:vision_app/features/resources_feature/presentation/academic_bloc/academic_bloc.dart';
import 'package:vision_app/features/resources_feature/presentation/requested_resource_bloc/requested_resource_bloc.dart';
import 'package:vision_app/features/resources_feature/presentation/resource_request_bloc/resource_request_bloc.dart';
import 'package:vision_app/features/resources_feature/presentation/view/advanced_resources_request_page.dart';
import 'package:vision_app/features/projects/presentation/view/create_project_page.dart';
import 'package:vision_app/features/auth/presentation/home_page.dart';
import 'package:vision_app/features/projects/presentation/view/project_details_page.dart';

class Routes {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: AppKeys.homePageKey,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (_) => sl<CurrentUserBloc>(), //!fix this
            child: HomePage(),
          ),
          transitionsBuilder: _fadeTransition,
        ),
      ),
      GoRoute(
        path: AppKeys.createProjectPageKey,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey, //! must fix here
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<ProjectDomainsBloc>()),
              BlocProvider(create: (_) => sl<CreateProjectBloc>()),
              BlocProvider(create: (_) => sl<UploadFileBloc>()),
            ],
            child: DialogScreen(),
          ),
          transitionsBuilder: _fadeTransition,
        ),
      ),
      GoRoute(
        path: AppKeys.advancedResourcesRequestPageKey,
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
                    data['projectId'], //!TODO : put these keys to the Appkeys class
                projectTitle: data['projectTitle'],
                //  projectOwner: data['projectOwner'],
                completedPercentage: data['completedPercentage'],
                projectFieldId: data['projectFieldID'],
              ),
            ),
            transitionsBuilder: _fadeTransition,
          );
        },
      ),
      GoRoute(
        path: AppKeys.projectDetailsPageKey,
        pageBuilder: (context, state) {
          //    final projectId = state.extra as String;
          return CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider(
              create: (_) => sl<ProjectDetailsBloc>(),
              child: ProjectDetailsPage(
                projectId:
                    '60248d28-6de3-489e-9d97-659cc5b5367b', //!dont' forget this
              ),
            ),
            transitionsBuilder: _fadeTransition,
          );
        },
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
