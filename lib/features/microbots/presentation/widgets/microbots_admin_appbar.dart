import 'package:flutter/material.dart';
import 'package:vision_app/core/res/app_images.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/features/microbots/presentation/widgets/search_container.dart';

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
              // Right: Tabs
              Row(
                children: List.generate(tabs.length, (index) {
                  final isSelected = selectedIndex == index;
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
                }),
              ),
              const Spacer(),

              // Center: Search
              if (isWide)
                Expanded(child: Center(child: SearchContainer()))
              else //TODO : make another better way
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
