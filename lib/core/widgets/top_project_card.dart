import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/widgets/project_network_image.dart';
import 'package:vision_app/features/auth/presentation/homePage_widgets/shimmer_line_widget.dart';

//!fix this widgete :
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

  // Constants
  static const double _cardWidth = 200;
  static const double _cardPadding = 8;
  static const double _imageHeight = 150;
  static const double _borderRadius = 16;
  static const double _shimmerHeight = 12;
  static const double _titleFontSize = 16;
  static const double _subtitleFontSize = 14;
  static const double _spacing = 12;
  static const double _smallSpacing = 8;
  static const double _shimmerTitleWidth = 0.95;
  static const double _shimmerSubtitleWidth = 0.75;
  static const Duration _shimmerDuration = Duration(milliseconds: 1500);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparentColor,
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(_borderRadius),
        child: Container(
          width: _cardWidth,
          //  height: _cardWidth,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(_cardPadding),
          decoration: _buildCardDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageWrapper(),
              const SizedBox(height: _spacing),
              _buildTextSection(),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
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
  }

  Widget _buildImageWrapper() {
    return Container(
      height: _imageHeight,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius),
        color: isLoading ? loadingColor ?? AppColors.gray200 : null,
      ),
      child: isLoading
          ? Container(color: loadingColor ?? AppColors.gray200)
          : ProjectNetworkImage(
              imageUrl: imageUrl!,
              borderRadius: _borderRadius,
              height: _imageHeight,
            ),
    );
  }

  Widget _buildTextSection() {
    if (isLoading) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildShimmerLine(widthFactor: _shimmerTitleWidth),
          const SizedBox(height: _smallSpacing),
          _buildShimmerLine(widthFactor: _shimmerSubtitleWidth),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          title!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: _titleFontSize,
            fontFamily: 'Mada-VariableFont_wght',
          ),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: _smallSpacing),
        Text(
          subtitle!,
          style: const TextStyle(
            color: AppColors.green,
            fontSize: _subtitleFontSize,
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }

  Widget _buildShimmerLine({required double widthFactor}) {
    return ShimmerLineWidget(
          widthFactor: widthFactor,
          shimmerHeight: _shimmerHeight,
        )
        .animate(onPlay: (c) => c.repeat())
        .shimmer(
          duration: _shimmerDuration,
          color: AppColors.whiteColor.withOpacity(0.6),
        );
  }
}
