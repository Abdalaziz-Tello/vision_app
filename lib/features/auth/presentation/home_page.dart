import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vision_app/core/di_storage_listner/auth_listener.dart';
import 'package:vision_app/core/res/app_images.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/res/keys/app_keys.dart';
import 'package:vision_app/core/res/keys/navigation_keys.dart';
import 'package:vision_app/features/auth/presentation/homePage_widgets/animated_custom_button.dart';
import 'package:vision_app/features/auth/presentation/homePage_widgets/app_bar_content.dart';
import 'package:vision_app/features/auth/presentation/homePage_widgets/header_section.dart';
import 'package:vision_app/features/auth/presentation/homePage_widgets/top_projects_listview.dart';
import 'package:vision_app/features/auth/presentation/state_managments/current_user_bloc/current_user_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final buttonKey = GlobalKey<AnimatedCustomButtonState>();

  final List<Color> cardColors = const [
    Color(0xFFFFD5CA),
    Color(0xFFC2FFDB),
    Color(0xFFFFF6CC),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startAuthStateListener(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CurrentUserBloc, CurrentUserState>(
      listener: (context, state) {
        if (state is CurrentUserLoaded) {
          final role = state.role;
          print('✅ تم تسجيل الدخول بدور: $role');
          if (role == AppKeys.microboostAdminKey) {
            context.go(NavigationKeys.microboostHomePage);
          }
        }
        //   if (role == 'student') {
        //   } else if (role == 'microboost_admin') {
        //     context.go(NavigationKeys.microboostHomePage);
        //     //  Navigator.pushReplacementNamed(context, '/adminDashboard');
        //   } else {
        //     print('⚠️ دور غير معروف: $role');
        //   }
        // }
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        extendBody: true,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBarContent(),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeaderSection(
                      buttonKey: buttonKey,
                    ), //header image + button of create projects
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        AppString.topProjects,
                        style: const TextStyle(
                          color: Color(0xff3A433E),
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TopProjectsListView(cardColors: cardColors),
                    SizedBox(height: 20),
                    Image.asset(
                      AppImages.footer,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
