import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vision_app/core/di_storage_listner/auth_listener.dart';
import 'package:vision_app/core/res/app_images.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/res/keys/navigation_keys.dart';
import 'package:vision_app/core/di_storage_listner/di.dart';
import 'package:vision_app/core/widgets/custom_snack_bar_function.dart';
import 'package:vision_app/features/auth/presentation/homePage_widgets/animated_custom_button.dart';
import 'package:vision_app/features/auth/presentation/homePage_widgets/top_project_card.dart';
import 'package:vision_app/features/auth/presentation/state_managments/auth_bloc/auth_bloc.dart';
import 'package:vision_app/features/auth/presentation/state_managments/current_user_bloc/current_user_bloc.dart';
import 'package:vision_app/features/auth/presentation/homePage_widgets/auth_dialog.dart';
import 'package:vision_app/features/auth/presentation/homePage_widgets/auth_dialog_manager.dart';
import 'package:vision_app/features/projects/presentation/top_projects_bloc/top_projects_bloc.dart';
import 'package:vision_app/features/projects/presentation/view/widgets/custom_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final buttonKey = GlobalKey<AnimatedCustomButtonState>();

  final List<Color> cardColors = [
    const Color(0xFFFFD5CA),
    const Color(0xFFC2FFDB),
    const Color(0xFFFFF6CC),
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
    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 600;
            return AppBar(
              backgroundColor: AppColors.whiteColor,
              elevation: 0,
              scrolledUnderElevation: 0,
              shadowColor: AppColors.whiteColor,
              automaticallyImplyLeading: false,
              title: null,
              flexibleSpace: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<CurrentUserBloc, CurrentUserState>(
                    builder: (context, state) {
                      print('CurrentUserBloc state: $state');
                      if (state is CurrentUserLoaded) {
                        final email = state.user.email;
                        final firstLetter = email.isNotEmpty
                            ? email[0].toUpperCase()
                            : '?';

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PopupMenuButton<int>(
                            tooltip: 'logOut',
                            color: AppColors.lightGrey,
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 0,
                                child: const Text("تسجيل الخروج"),
                                onTap: () {
                                  // Future.delayed(Duration.zero, () {
                                  //   context.read<CurrentUserBloc>().add(LogoutRequested());
                                  // });
                                },
                              ),
                            ],
                            child: CircleAvatar(
                              backgroundColor: AppColors.navyBlue,
                              child: Text(
                                firstLetter,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      } else {
                        // المستخدم غير مسجل دخول
                        return isWide
                            ? Wrap(
                                spacing: 12,
                                children: [
                                  _buildAuthButton(
                                    text: AppString.login,
                                    isLogin: true,
                                  ),
                                  _buildAuthButton(
                                    text: AppString.signup,
                                    isLogin: false,
                                  ),
                                ],
                              )
                            : PopupMenuButton<int>(
                                color: AppColors.lightGrey,
                                tooltip: 'Account',
                                icon: const Icon(
                                  Icons.manage_accounts,
                                  color: AppColors.navyBlue,
                                ),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 0,
                                    child: Text(AppString.login),
                                    onTap: () => Future.delayed(
                                      Duration.zero,
                                      () => _showAuthDialog(context, true),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 1,
                                    child: Text(AppString.signup),
                                    onTap: () => Future.delayed(
                                      Duration.zero,
                                      () => _showAuthDialog(context, false),
                                    ),
                                  ),
                                ],
                              );
                      }
                    },
                  ),
                  Image.asset(AppImages.logo, width: 120, fit: BoxFit.contain),
                ],
              ),
            );
          },
        ),
      ),

      backgroundColor: AppColors.whiteColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        AppImages.header,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      AnimatedCustomButton(
                        key: buttonKey,
                        text: AppString.showYourProjectNow,
                        bgColor: AppColors.brightBlue,
                        textColor: AppColors.navyBlue,
                        onTap: () {
                          final state = context.read<CurrentUserBloc>().state;
                          if (state is CurrentUserLoaded) {
                            context.push(NavigationKeys.createProjectPageKey);
                          } else {
                            buttonKey.currentState?.triggerShake();
                            ScaffoldMessenger.of(context).showSnackBar(
                              customSnackBar(
                                'Please login to create a project',
                                AppColors.redColor,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ).animate().slideX(
                    delay: 0.2.seconds,
                    duration: 0.2.seconds,
                    begin: -1,
                  ),
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
                  ).animate().fadeIn(delay: 0.3.seconds, duration: 0.4.seconds),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      height: 250,
                      child: BlocBuilder<TopProjectsBloc, TopProjectsState>(
                        builder: (context, state) {
                          if (state is TopProjectsLoading) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                final color =
                                    cardColors[index % cardColors.length];
                                return ProjectCard(
                                  isLoading: true,
                                  loadingColor: color,
                                );
                              },
                            );
                          } else if (state is TopProjectsSuccess) {
                            final projects = state.projects;
                            if (projects.isEmpty) {
                              return const Center(
                                child: Text("لا توجد مشاريع بعد"),
                              );
                            }

                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: projects.length,
                              itemBuilder: (context, index) {
                                final project = projects[index];
                                return ProjectCard(
                                  imageUrl: project.coverImageUrl,
                                  title: project.title,
                                  subtitle:
                                      "${project.percentageCompleted}٪ مكتمل",
                                  onTap: () {
                                    // navigate to details
                                  },
                                );
                              },
                            );
                          } else if (state is TopProjectsFailure) {
                            return Center(child: Text("خطأ: ${state.error}"));
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                  ).animate().fadeIn(
                    delay: 0.35.seconds,
                    duration: 0.45.seconds,
                  ),
                  //  Spacer(),//!
                  Image.asset(
                    AppImages.footer,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ).animate().slideX(
                    delay: 0.2.seconds,
                    duration: 0.2.seconds,
                    begin: 1,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAuthButton({required String text, required bool isLogin}) {
    return AuthDialogManager(
      isLogin: isLogin,
      child: CustomButton(
        text: text,
        bgColor: isLogin ? AppColors.lightBlue : Colors.white,
        textColor: isLogin ? Colors.white : AppColors.lightBlue,
        onTap: null, // Handled by AuthDialogManager
      ),
    );
  }

  void _showAuthDialog(BuildContext context, bool isLogin) {
    showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (_) => sl<AuthBloc>(),
        child: AuthDialog(
          isLogin: isLogin,
          onSuccess: () {
            context.pop();

            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                isLogin
                    ? 'success'
                    : "Check your email ..We've sent a confirmation link to your email",
                AppColors.green,
              ),
              //  SnackBar(content: Text(), backgroundColor: Colors.green),
            );
            if (!isLogin) {
              // فقط إذا كانت تسجيل جديد
              showDialog(
                context: context,
                builder: (_) => const VerificationDialog(),
              );
            }
          },
        ),
      ),
    );
  }
}

class VerificationDialog extends StatelessWidget {
  const VerificationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.reallyWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300, minHeight: 200),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.mark_email_read_outlined,
                    color: AppColors.lightBlue,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'تحقق من بريدك الإلكتروني',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'لقد أرسلنا رابط تأكيد إلى بريدك الإلكتروني.\nيرجى فتحه لتفعيل الحساب.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'حسناً',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
