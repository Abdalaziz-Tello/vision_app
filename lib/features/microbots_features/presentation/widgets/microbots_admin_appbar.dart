import 'package:flutter/material.dart';
import 'package:vision_app/core/res/app_images.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/features/microbots_features/presentation/widgets/search_container.dart';

// appbar , that contains the logo , the tabs and the search

class MicrobotsAdminAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;
  final bool showSearch;
  final VoidCallback onSearchTap;

  MicrobotsAdminAppBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.showSearch,
    required this.onSearchTap,
  });

  final List<String> tabs = [
    AppString.project,
    AppString.requests,
    AppString.equipment,
  ];

  //icons for tabs
  final List<IconData> tabIcons = [
    Icons.dashboard_outlined, //  project
    Icons.description_outlined, // requests
    Icons.build_outlined, //  equipment
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;

        return AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.whiteColor,
          shadowColor: AppColors.whiteColor,
          scrolledUnderElevation: 0,
          elevation: 0,
          title: Row(
            children: [
              // Right: Tabs //TODO : check the Dimensions
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(tabs.length, (index) {
                  final isSelected = selectedIndex == index;

                  if (isWide) {
                    // Wide screen:text tabs
                    return InkWell(
                      onTap: () => onTabSelected(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          border: isSelected
                              ? const Border(
                                  bottom: BorderSide(
                                    color: AppColors.navyBlue,
                                    width: 2,
                                  ),
                                )
                              : null,
                        ),
                        child: Text(
                          tabs[index],
                          style: TextStyle(
                            fontSize: 16,
                            color: isSelected
                                ? AppColors.navyBlue
                                : AppColors.blackColor,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  } else {
                    // Small screen:icon with tooltip
                    return Tooltip(
                      message: tabs[index],
                      waitDuration: const Duration(milliseconds: 500),
                      child: InkWell(
                        onTap: () => onTabSelected(index),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 2,
                          ),
                          decoration: BoxDecoration(
                            border: isSelected
                                ? const Border(
                                    bottom: BorderSide(
                                      color: AppColors.navyBlue,
                                      width: 2,
                                    ),
                                  )
                                : null,
                          ),
                          child: Icon(
                            tabIcons[index],

                            color: isSelected
                                ? AppColors.navyBlue
                                : AppColors.gray800,
                          ),
                        ),
                      ),
                    );
                  }
                }),
              ),

              const Spacer(),

              // Center: Search
              if (isWide)
                Expanded(child: Center(child: SearchContainer()))
              else
                IconButton(
                  onPressed: onSearchTap,
                  icon: const Icon(Icons.search, color: AppColors.gray600),
                ),

              const Spacer(),

              // Logo
              Image.asset(AppImages.logo, width: 120, fit: BoxFit.contain),
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
