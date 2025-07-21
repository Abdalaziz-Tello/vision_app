import 'package:flutter/material.dart';
import 'package:vision_app/core/res/color/app_colors.dart';

class ProjectNetworkImage extends StatelessWidget {
  final String? imageUrl;
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
    if (imageUrl == null || imageUrl!.isEmpty) {
      // Fallback for null or empty
      return Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.gray100,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Icon(
            Icons.image_not_supported,
            size: 40,
            color: AppColors.gray600,
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        imageUrl!,
        fit: BoxFit.fill,
        height: height,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(Icons.broken_image, size: 40, color: AppColors.gray600),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(
            child: CircularProgressIndicator(color: AppColors.navyBlue),
          );
        },
      ),
    );
  }
}
