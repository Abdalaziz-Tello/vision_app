import 'package:flutter/material.dart';
import 'package:vision_app/core/res/app_images.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/features/view/widgets/custom_button.dart';
import 'package:vision_app/features/view/widgets/custom_circular_progress.dart';
import 'package:vision_app/features/view/widgets/enumeration_item.dart';
//TODO : make them static

class ProjectDetailsPage extends StatelessWidget {
  const ProjectDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        shadowColor: AppColors.whiteColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 160,
              height: 40,
              child: CustomButton(
                text: 'مشاركة المشروع',
                textColor: AppColors.whiteColor,
                bgColor: AppColors.vibrantMintGreen,
                borderColor: AppColors.vibrantMintGreen,
              ),
            ),

            Image.asset(AppImages.logo, width: 120, fit: BoxFit.contain),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              EnumerationItem(
                text: 'مشروع منصة استيراد و تصدير ',
                circleSize: 12,
                circleColor: AppColors.vibrantMintGreen,
                fontSize: 18,
                textColor: Colors.black87,
                isBold: true,
              ),
              EnumerationItem(
                text: 'منصة لاستيراد و تصدير القطع الصناعية و صمامات النفط ',
                circleSize: 10,
                circleColor: AppColors.vibrantMintGreen,
                fontSize: 16,
                textColor: AppColors.gray600,
                isBold: true,
              ),
              EnumerationItem(
                text: 'من قبل : جميل جمال',
                circleSize: 8,
                circleColor: AppColors.vibrantMintGreen,
                fontSize: 14,
                textColor: AppColors.gray600,
                isBold: true,
              ),
              SizedBox(height: 10),
              Container(
                //   margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.reallyWhite,
                  border: Border.all(color: AppColors.gray100),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    CustomCircularProgress(
                      percentage:
                          0.20, // 20% //TODO : depend on backend , make function
                      size: 140,
                      // activeColor: Colors.green,
                      // inactiveColor: Colors.grey.shade300,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'يتم عرض مشروعك  عند إنجاز 50% عالاقل من المشروع',
                      style: TextStyle(
                        color: AppColors.gray800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.blue50,
                  // border: Border.all(color: AppColors.gray100),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: AppColors.navyBlue),
                    SizedBox(width: 10),
                    Text(
                      'لا يمكنك تفعيل صفحتك حتى يوافق على مشروعك',
                      style: TextStyle(color: AppColors.navyBlue),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
