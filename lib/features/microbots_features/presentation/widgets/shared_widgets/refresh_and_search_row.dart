import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:vision_app/features/microbots_features/presentation/widgets/shared_widgets/search_container.dart';
import 'package:vision_app/features/microbots_features/presentation/widgets/shared_widgets/web_refresh_widget.dart';

class RefreshAndSearchRow extends StatelessWidget {
  final VoidCallback onRefresh;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onSearchCleared;

  const RefreshAndSearchRow({
    super.key,
    required this.onRefresh,
    required this.searchController,
    required this.onSearchChanged,
    required this.onSearchCleared,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          if (kIsWeb) WebRefreshWidget(onRefresh: onRefresh),
          const SizedBox(width: 12),
          Expanded(
            child: SearchContainer(
              controller: searchController,
              onChanged: onSearchChanged,
              onClose: onSearchCleared,
            ),
          ),
        ],
      ),
    );
  }
}
