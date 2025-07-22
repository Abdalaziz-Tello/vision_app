import 'package:flutter/material.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/shared/widgets/project_network_image.dart';
import 'package:vision_app/core/shared/widgets/projects_container/custom_circular_progress.dart';
import 'package:vision_app/core/shared/widgets/projects_container/visible_or_not_row.dart';

// //!fix this widgets , make sure from the flexible :

class ProjectCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double percentage;
  final bool isVisible;
  final String creatorName;
  final VoidCallback? onTap;

  const ProjectCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.percentage,
    this.onTap,
    required this.isVisible,
    required this.creatorName,
  });

  static const double _cardWidth = 200;
  static const double _cardPadding = 8;
  static const double _imageHeight = 150;
  static const double _borderRadius = 16;
  static const double _titleFontSize = 20;
  static const double _subtitleFontSize = 14;
  static const double _spacing = 12;
  static const double _smallSpacing = 8;
  // static const double _customCircularProgressSize = 80;
  // static const double _strokeWidth = 2;
  //Material
  // color: AppColors.transparentColor,
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(_borderRadius),
      child: Container(
        width: _cardWidth,
        //  height: 280, //!
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(_cardPadding),
        decoration: _buildCardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageWrapper(),
            const SizedBox(height: _spacing),
            Expanded(child: _buildTextSection()),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildCardDecoration() => BoxDecoration(
    color: AppColors.reallyWhite,
    borderRadius: BorderRadius.circular(_borderRadius),
    boxShadow: [
      BoxShadow(
        color: AppColors.blackColor.withOpacity(0.05),
        offset: const Offset(2, 2),
        blurRadius: 6,
        spreadRadius: 2,
      ),
    ],
  );

  Widget _buildImageWrapper() => Container(
    height: _imageHeight,
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      color: AppColors.gray100,
      borderRadius: BorderRadius.circular(_borderRadius),
    ),
    child: ProjectNetworkImage(
      imageUrl: imageUrl,
      borderRadius: _borderRadius,
      height: _imageHeight,
    ),
  );

  Widget _buildTextSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: _titleFontSize,
          fontFamily: 'Mada-VariableFont_wght',
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      const SizedBox(height: _smallSpacing),
      Row(
        children: [
          VisibleOrNotRow(isPublic: isVisible),
          const SizedBox(width: 4),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.person_outline,
                  color: AppColors.green,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    creatorName,
                    style: const TextStyle(
                      fontSize: _subtitleFontSize,
                      color: AppColors.gray800,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: _smallSpacing),
      Row(
        children: [
          Expanded(
            child: Text(
              AppString.projectCompleted,
              style: TextStyle(
                fontSize: _subtitleFontSize,
                color: AppColors.gray800,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          CustomCircularProgress(percentage: percentage),
        ],
      ),
    ],
  );
}
