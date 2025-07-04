import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vision_app/core/res/app_keys.dart';
import 'package:vision_app/core/storage/di.dart';
import 'package:vision_app/features/auth/presentation/current_user_bloc/current_user_bloc.dart';
import 'package:vision_app/features/projects/presentation/create_project_bloc/create_project_bloc.dart';
import 'package:vision_app/features/projects/presentation/project_domains_bloc/project_domains_bloc.dart';
import 'package:vision_app/features/view/pages/advanced_resources_request_page.dart';
import 'package:vision_app/features/projects/presentation/create_project_page.dart';
import 'package:vision_app/features/auth/presentation/home_page.dart';
import 'package:vision_app/features/view/pages/project_details_page.dart';

class Routes {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: AppKeys.homePageKey,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (_) => sl<CurrentUserBloc>(),//!fix this
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
            ],
            child: DialogScreen(),
          ),
          transitionsBuilder: _fadeTransition,
        ),
      ),
      GoRoute(
        path: AppKeys.advancedResourcesRequestPageKey,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: AdvancedResourcesRequestPage(),
          transitionsBuilder: _fadeTransition,
        ),
      ),
      GoRoute(
        path: AppKeys.projectDetailsPageKey,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: ProjectDetailsPage(),
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
