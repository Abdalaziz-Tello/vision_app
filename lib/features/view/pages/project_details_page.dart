import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vision_app/core/res/app_images.dart';
import 'package:vision_app/core/res/app_keys.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/features/view/widgets/create_project_widgets/cover_image_picker_widget.dart';
import 'package:vision_app/features/view/widgets/create_project_widgets/glowing_circle_with_text.dart';
import 'package:vision_app/features/view/widgets/create_project_widgets/input_field_widget.dart';
import 'package:vision_app/features/view/widgets/create_project_widgets/pdf_picker_widget.dart';
import 'package:vision_app/features/view/widgets/custom_button.dart';
import 'package:vision_app/features/view/widgets/custom_circular_progress.dart';
import 'package:vision_app/features/view/widgets/enumeration_item.dart';
//TODO : make them static

class ProjectDetailsPage extends StatefulWidget {
  const ProjectDetailsPage({super.key});

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  late TextEditingController projectObjectivesController;
  PlatformFile? coverImage;
  List<PlatformFile> selectedFiles = [];

  @override
  void initState() {
    super.initState();
    projectObjectivesController = TextEditingController();
  }

  @override
  void dispose() {
    projectObjectivesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.reallyWhite,
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              EnergeticCircleWithFocus(),
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
              Row(
                children: [
                  Icon(Icons.lock, color: AppColors.gray800),
                  SizedBox(width: 10),
                  Text(
                    'غير معروض ',
                    style: TextStyle(
                      color: AppColors.gray800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              EnumerationItem(
                text: 'أهداف المشروع ',
                circleColor: AppColors.orange,
                fontSize: 24,
                isBold: true,
              ),
              SizedBox(height: 5),
              InputFieldWidget(
                controller: projectObjectivesController,
                hintText: '',
              ),

              SizedBox(height: 10),
              CoverImagePickerWidget(
                width: double.infinity,
                currentImage: coverImage,
                onImagePicked: (img) => setState(() {
                  coverImage = img;
                }),
              ),
              SizedBox(height: 10),
              PdfPickerWidget(
                width: double.infinity,
                onFilesPicked: (files) => setState(() {
                  selectedFiles.addAll(files);
                }),
              ),
              SizedBox(height: 10),
              Container(
                //   margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.reallyWhite,
                  border: Border.all(color: AppColors.gray100),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      'هل ينقصك بعض الأدوات لإكمال مشروعك ؟',
                      style: TextStyle(
                        color: AppColors.gray800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        context.push(AppKeys.advancedResourcesRequestPageKey);
                      },
                      child: Text(
                        'طلب موارد متقدمة',
                        style: TextStyle(
                          color: AppColors.brightBlue,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.brightBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
