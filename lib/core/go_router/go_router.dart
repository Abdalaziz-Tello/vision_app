import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vision_app/core/res/app_keys.dart';
import 'package:vision_app/features/view/create_project_page.dart';
import 'package:vision_app/features/auth/presentation/home_page.dart';

class Routes {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: AppKeys.homePageKey,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: HomePage(),
          transitionsBuilder: _fadeTransition,
        ),
      ),
      GoRoute(
        path: AppKeys.createProjectPageKey,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: DialogScreen(),
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
