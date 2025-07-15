import 'package:flutter/material.dart';
import 'package:vision_app/core/res/color/app_colors.dart';

//used in projectDetails (AttachmentPicker widget) page and in homepage

class ProjectNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double borderRadius;
  final double height;

  const ProjectNetworkImage({
    super.key,
    required this.imageUrl,
    required this.borderRadius,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.fill,
      height: height,
      width: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return Center(
          child: Icon(Icons.broken_image, size: 40, color: AppColors.gray600),
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(
          child: CircularProgressIndicator(color: AppColors.navyBlue),
        );
      },
    );
  }
}
