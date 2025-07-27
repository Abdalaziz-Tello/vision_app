import 'package:flutter/material.dart';
import 'package:vision_app/features/microbots_features/presentation/widgets/admin_tab.dart';

class MicrobotsAdminTabsView extends StatelessWidget {
  final PageController controller;
  final ValueChanged<int> onPageChanged;

  const MicrobotsAdminTabsView({
    super.key,
    required this.controller,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller,
      onPageChanged: onPageChanged,
      children: const [
        AdminProjectsTab(),
        AdminResourcesTab(),
        AdminToolsTab(),
      ],
    );
  }
}
