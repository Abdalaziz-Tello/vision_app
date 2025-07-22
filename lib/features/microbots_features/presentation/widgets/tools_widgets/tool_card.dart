import 'package:flutter/material.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/shared/widgets/project_network_image.dart';
import 'package:vision_app/core/shared/widgets/text_with_expansion_tile_selector.dart';

class ToolCard extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final int totalCount;
  final int loanedCount;
  final String availabilityStatus;
  final void Function(String)? onStatusChanged;

  const ToolCard({
    super.key,
    this.imageUrl,
    required this.title,
    required this.totalCount,
    required this.availabilityStatus,
    this.onStatusChanged,
    required this.loanedCount,
  });

  static const double _imageHeight = 100;
  static const double _borderRadius = 12;
  static const double _titleFontSize = 20;

  Widget _buildImageWrapper() => Container(
    height: _imageHeight,
    width: _imageHeight,
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

  @override
  Widget build(BuildContext context) {
    final isAvailable = availabilityStatus == 'available';

    final selectedArabicValue = isAvailable ? 'متاحة' : 'غير متاحة';

    final statusOptions = isAvailable ? ['غير متاحة'] : ['متاحة'];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(10),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageWrapper(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title and Info Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,

                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: _titleFontSize,
                          fontFamily: 'Mada-VariableFont_wght',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      Icons.info_outline,
                      size: 25,
                      color: AppColors.gray600,
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                /// Count
                Text('total: $totalCount'),
                const SizedBox(height: 8),
                Text('loanedCount: $loanedCount'),
                const SizedBox(height: 8),
                TextWithExpansionTileSelector(
                  selectedValue: selectedArabicValue,
                  options: statusOptions,
                  textColor: isAvailable ? AppColors.green : AppColors.redColor,
                  primaryColor: AppColors.whiteColor,
                  onSelected: (value) {
                    print(value);
                    onStatusChanged?.call(
                      value == 'متاحة' ? 'available' : 'notAvailable',
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
