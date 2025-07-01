import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vision_app/core/res/app_images.dart';
import 'package:vision_app/core/res/app_keys.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/features/auth/injection.dart';
import 'package:vision_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vision_app/features/auth/presentation/homePage_widgets/auth_dialog.dart';
import 'package:vision_app/features/auth/presentation/homePage_widgets/auth_dialog_manager.dart';
import 'package:vision_app/features/auth/presentation/homePage_widgets/loading_card_with_lines.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Color> cardColors = [
    const Color(0xFFFFD5CA),
    const Color(0xFFC2FFDB),
    const Color(0xFFFFF6CC),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  isWide
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
                        ),
                  Image.asset(AppImages.logo, width: 120, fit: BoxFit.contain),
                ],
              ),
            );
          },
        ),
      ),
      backgroundColor: AppColors.whiteColor,
      body: ListView(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.asset(
                AppImages.header,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _buildButton(
                  text: AppString.showYourProjectNow,
                  bgColor: AppColors.brightBlue,
                  textColor: AppColors.navyBlue,
                  height: 50,
                  width: 170,
                  onTap: () {
                    context.push(AppKeys.createProjectPageKey);
                  },
                ),
              ),
            ],
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
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: 250,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final cardWidth = constraints.maxWidth * 0.45;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: cardWidth,
                        child: LoadingCard(
                          backgroundColor: cardColors[index % cardColors.length],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Image.asset(
            AppImages.footer,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  Widget _buildAuthButton({
    required String text,
    required bool isLogin,
  }) {
    return AuthDialogManager(
      isLogin: isLogin,
      child: _buildButton(
        text: text,
        bgColor: isLogin ? AppColors.lightBlue : Colors.white,
        textColor: isLogin ? Colors.white : AppColors.lightBlue,
        onTap: null, // Handled by AuthDialogManager
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required Color bgColor,
    required Color textColor,
    double width = 160,
    double height = 40,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: AppColors.lightBlue),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _showAuthDialog(BuildContext context, bool isLogin) {
    showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (_) => AuthBloc(
          signInWithEmailAndPassword: sl(),
          signUpWithEmailAndPassword: sl(),
        ),
        child: AuthDialog(
          isLogin: isLogin,
          onSuccess: () => context.pop(),
        ),
      ),
    );
  }
}