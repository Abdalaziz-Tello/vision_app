import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vision_app/core/res/app_images.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/res/keys/app_keys.dart';
import 'package:vision_app/core/shared/widgets/custom_button.dart';
import 'package:vision_app/core/shared/widgets/custom_snack_bar_function.dart';

class ProjectDetailsAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const ProjectDetailsAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      shadowColor: AppColors.whiteColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: CustomButton(
              text: AppString.shareProject,
              textColor: AppColors.whiteColor,
              bgColor: AppColors.vibrantMintGreen,
              borderColor: AppColors.vibrantMintGreen,
              onTap: () async {
                final appUrl = AppKeys.webUrl;
                //to share the project :
                Share.share('''
               ${AppString.visionPlatformIntro}

                🔗 $appUrl
                  ''');

                await Clipboard.setData(ClipboardData(text: appUrl));
                ScaffoldMessenger.of(context).showSnackBar(
                  // const SnackBar(content: Text('📋 تم نسخ رابط الموقع!')),
                  customSnackBar(AppString.linkCopied, AppColors.green),
                );
              },
            ),
          ),
          Image.asset(AppImages.logo, width: 120, fit: BoxFit.contain),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
