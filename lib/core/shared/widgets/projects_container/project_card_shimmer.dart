import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/shared/widgets/projects_container/shimmer_line_widget.dart';

class ProjectCardShimmer extends StatelessWidget {
  final Color color;
  const ProjectCardShimmer({super.key, required this.color});

  static const double _cardWidth = 200;
  static const double _cardPadding = 8;
  static const double _imageHeight = 150;
  static const double _borderRadius = 16;
  static const double _shimmerHeight = 13;
  static const double _spacing = 20;
  // static const double _smallSpacing = 8;
  static const double _shimmerTitleWidth = 0.95;
  static const double _shimmerSubtitleWidth = 0.75;
  static const double _shimmerSubtitle2Width = 0.65;
  static const Duration _shimmerDuration = Duration(milliseconds: 1500);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _cardWidth,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(_cardPadding),
      decoration: _buildCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildImageShimmer(),
          const SizedBox(height: _spacing),
          _buildTextShimmer(),
        ],
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

  Widget _buildImageShimmer() =>
      Container(
            height: _imageHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_borderRadius),
              color: color, // AppColors.gray200,
            ),
          )
          .animate(onPlay: (c) => c.repeat())
          .shimmer(
            duration: _shimmerDuration,
            color: AppColors.whiteColor.withOpacity(0.5),
          );

  Widget _buildTextShimmer() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _buildShimmerLine(_shimmerSubtitle2Width),
      const SizedBox(height: _spacing),
      _buildShimmerLine(_shimmerTitleWidth),
      const SizedBox(height: _spacing),
      _buildShimmerLine(_shimmerSubtitleWidth),
    ],
  );

  Widget _buildShimmerLine(double widthFactor) {
    return ShimmerLineWidget(
          widthFactor: widthFactor,
          shimmerHeight: _shimmerHeight,
          radius: _borderRadius,
        )
        .animate(onPlay: (c) => c.repeat())
        .shimmer(
          duration: _shimmerDuration,
          color: AppColors.whiteColor.withOpacity(0.6),
        );
  }
}
