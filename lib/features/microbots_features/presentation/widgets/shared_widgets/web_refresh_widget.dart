import 'package:flutter/material.dart';
import 'package:vision_app/core/res/color/app_colors.dart';

// class WebRefreshWidget extends StatelessWidget {
//   const WebRefreshWidget({super.key, required this.onRefresh});

//   final Future<void> Function() onRefresh;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: GestureDetector(
//         onTap: onRefresh,
//         child: Card(
//           elevation: 2,
//           color: AppColors.blue50,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//           child: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 Icon(Icons.refresh, size: 20, color: AppColors.navyBlue),
//                 SizedBox(width: 8),
//                 Text(" للتحديث", style: TextStyle(color: AppColors.brightBlue)),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//? or this :
class WebRefreshWidget extends StatelessWidget {
  const WebRefreshWidget({super.key, required this.onRefresh});

  final void Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.refresh, color: AppColors.navyBlue),
      tooltip: 'تحديث',
      onPressed: onRefresh,
    );
  }
}
