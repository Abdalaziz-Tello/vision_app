import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/res/keys/navigation_keys.dart';
import 'package:vision_app/features/projects/domain/entities/project_entity.dart';

class AdvancedResourceRequestBanner extends StatelessWidget {
  const AdvancedResourceRequestBanner({super.key, required this.project});

  final ProjectEntity project;
  //?! i don't know if its correct to pass the entity itself , but it much easier , because we use many things inside of it

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.reallyWhite,
        border: Border.all(color: AppColors.gray100),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              AppString
                  .missingToolsPrompt, //  'هل ينقصك بعض الأدوات لإكمال مشروعك؟',
              style: TextStyle(
                color: AppColors.gray800,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              context.push(
                NavigationKeys.advancedResourcesRequestPageKey,
                extra: {
                  NavigationKeys.projectIdKey: project.id,
                  NavigationKeys.projectTitleKey: project.title,
                  //  'projectOwner': project.,
                  NavigationKeys.completedPercentageKey:
                      project.percentageCompleted,
                  NavigationKeys.projectFieldIdKey: project.projectDomainId,
                  NavigationKeys.projectDomainName: project.projectDomainName,
                  NavigationKeys.projectOwnerName: project.projectOwnerName,
                },
              );
            },
            child: Text(
              AppString.requestAdvancedResources, // 'طلب موارد متقدمة',
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
    );
  }
}
