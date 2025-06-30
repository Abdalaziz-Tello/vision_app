//TODO : change the name :|
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vision_app/core/res/app_images.dart';
import 'package:vision_app/core/res/app_keys.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/features/auth/injection.dart';
import 'package:vision_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vision_app/features/auth/presentation/homePage_widgets/loading_card_with_lines.dart';
import 'package:vision_app/features/auth/presentation/homePage_widgets/auth_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Color> cardColors = [
    Color(0xFFFFD5CA),
    Color(0xFFC2FFDB),
    Color(0xFFFFF6CC),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: ListView(
        children: [
          // Wrap(
          //   alignment: WrapAlignment.center,
          //   spacing: 16,
          //   runSpacing: 16,
          //   children: [
          //     _buildButton(AppString.login, Colors.white, AppColors.lightBlue),
          //     _buildButton(AppString.signup, AppColors.lightBlue, Colors.white),
          //     Image.asset(AppImages.logo, width: 150),
          //   ],
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                bool isWide = constraints.maxWidth >= 600;
                //  bool isRtl = Directionality.of(context) == TextDirection.rtl;

                if (isWide) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildButton(
                            AppString.login,
                            AppColors.lightBlue,
                            Colors.white,
                          ),
                          _buildButton(
                            AppString.signup,
                            Colors.white,
                            AppColors.lightBlue,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          AppImages.logo,
                          width: 120,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        AppImages.logo,
                        width: 120,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          alignment: WrapAlignment.center,
                          children: [
                            _buildButton(
                              AppString.login,
                              AppColors.lightBlue,
                              Colors.white,
                              onTap: () {
                                showLoginDialog(context);
                              },
                            ),
                            _buildButton(
                              AppString.signup,
                              Colors.white,
                              AppColors.lightBlue,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),

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
                  AppString.showYourProjectNow,
                  AppColors.brightBlue,
                  AppColors.navyBlue,
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
              style: TextStyle(
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
                  double cardWidth = constraints.maxWidth * 0.45;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: cardWidth,
                        // child: ColoredCardWithContent(
                        //   imageAsset: AppImages.logo,
                        //   title: 'منصة تصدير و إدارة التبادل${index + 1}',
                        //   subtitle: 'معروض',
                        // ),
                        child: LoadingCard(
                          backgroundColor:
                              cardColors[index % cardColors.length],
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

  Widget _buildButton(
    String text,
    Color bgColor,

    Color textColor, {
    double width = 185,
    double height = 55,
    void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
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
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Future<void> showLoginDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return BlocProvider(
          create: (context) => AuthBloc(sl()),
          child: AuthDialog(),
        );
      },
    );
  }
}
