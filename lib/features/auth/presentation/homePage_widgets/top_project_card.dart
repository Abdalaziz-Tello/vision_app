import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vision_app/core/res/color/app_colors.dart';

class ProjectCard extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final String? subtitle;
  final bool isLoading;
  final VoidCallback? onTap;
  final Color? loadingColor;

  const ProjectCard({
    super.key,
    this.imageUrl,
    this.title,
    this.subtitle,
    this.onTap,
    this.isLoading = false,
    this.loadingColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: 200,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.reallyWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withOpacity(0.05),
              offset: const Offset(2, 2),
              blurRadius: 6,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isLoading ? loadingColor ?? Colors.grey[300] : null,
              ),
              clipBehavior: Clip.antiAlias,
              child: isLoading
                  ? _buildShimmerBox()
                  : Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (_, __, ___) => const Center(
                        child: Icon(
                          Icons.broken_image,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.navyBlue,
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 12),
            isLoading
                ? _buildShimmerLine(widthFactor: 0.9)
                : Text(
                    title!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Mada-VariableFont_wght',
                    ),
                    textAlign: TextAlign.right,
                  ),
            const SizedBox(height: 8),
            isLoading
                ? _buildShimmerLine(widthFactor: 0.75)
                : Text(
                    subtitle!,
                    style: const TextStyle(
                      color: Color(0xff49B575),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.right,
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerBox() {
    return Container()
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer();
  }

  Widget _buildShimmerLine({required double widthFactor}) {
    return FractionallySizedBox(
      alignment: Alignment.centerRight,
      widthFactor: widthFactor,
      child: Container(
        height: 12,
        decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
      ),
    ).animate(onPlay: (controller) => controller.repeat()).shimmer();
  }
}
